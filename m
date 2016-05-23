Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32975 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726AbcEWKc0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 May 2016 06:32:26 -0400
Message-ID: <1463999616.31269.34.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] thunderbolt: Communication with the ICM (firmware)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Amir Levy <amir.jer.levy@intel.com>, andreas.noever@gmail.com,
	gregkh@linuxfoundation.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, michael.jamet@intel.com,
	dan.alloun@intel.com, mika.westerberg@intel.com,
	kai.svahn@intel.com, tomas.winkler@intel.com
Date: Mon, 23 May 2016 13:33:36 +0300
In-Reply-To: <1463993336-2750-3-git-send-email-amir.jer.levy@intel.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
	 <1463993336-2750-3-git-send-email-amir.jer.levy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2016-05-23 at 11:48 +0300, Amir Levy wrote:
> Firmware-based (a.k.a ICM - Intel Connection Manager) controller is
> used for establishing and maintaining the Thunderbolt Networking
> connection. We need to be able to communicate with it.

> --- a/drivers/thunderbolt/Makefile
> +++ b/drivers/thunderbolt/Makefile
> @@ -1,3 +1,2 @@
>  obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
> -thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o
> tunnel_pci.o eeprom.o
> -
> +thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o
> tunnel_pci.o eeprom.o icm_nhi.o

> \ No newline at end of file

Something wrong with an editor?

> diff --git a/drivers/thunderbolt/icm_nhi.c
> b/drivers/thunderbolt/icm_nhi.c
> new file mode 100644
> index 0000000..5b7e448
> --- /dev/null
> +++ b/drivers/thunderbolt/icm_nhi.c
> @@ -0,0 +1,1241 @@
> +/********************************************************************
> ***********
> + *
> + * Intel Thunderbolt(TM) driver
> + * Copyright(c) 2014 - 2016 Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but
> WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along
> + * with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * The full GNU General Public License is included in this
> distribution in
> + * the file called "COPYING".
> + *


> + * Contact Information:
> + * Intel Thunderbolt Mailing List <thunderbolt-software@lists.01.org>

We have MAINTAINERS for that, have we?

> + * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR
> 97124-6497

I doubt it makes sense here.

> + *
> +
> **********************************************************************
> ********/

Not every maintainer likes long star lines.

> +
> +#include <linux/printk.h>
> +#include <linux/crc32.h>
> +#include <linux/delay.h>
> +#include <linux/pci.h>

+ empty line

> +#include "nhi_regs.h"
> +#include "icm_nhi.h"
> +#include "net.h"
> +
> 

> +#define NHI_CMD_MAX (__NHI_CMD_MAX - 1)

MAX should be MAX¸ not MAX-1, otherwise the name is chosen poorly.

> +
> +/* NHI genetlink policy */
> +static const struct nla_policy nhi_genl_policy[NHI_ATTR_MAX + 1] = {
> +	[NHI_ATTR_DRV_VERSION]		= { .type =
> NLA_NUL_STRING, },
> +	[NHI_ATTR_NVM_VER_OFFSET]	= { .type = NLA_U16, },
> +	[NHI_ATTR_NUM_PORTS]		= { .type = NLA_U8, },
> +	[NHI_ATTR_DMA_PORT]		= { .type = NLA_U8, },
> +	[NHI_ATTR_SUPPORT_FULL_E2E]	= { .type = NLA_FLAG, },
> +	[NHI_ATTR_MAILBOX_CMD]		= { .type = NLA_U32, },
> +	[NHI_ATTR_PDF]			= { .type = NLA_U32, },
> +	[NHI_ATTR_MSG_TO_ICM]		= { .type = NLA_BINARY,
> +					.len =
> TBT_ICM_RING_MAX_FRAME_SIZE },
> +	[NHI_ATTR_MSG_FROM_ICM]		= { .type =
> NLA_BINARY,
> +					.len =
> TBT_ICM_RING_MAX_FRAME_SIZE },
> +};
> +
> +/* NHI genetlink family */
> +static struct genl_family nhi_genl_family = {
> +	.id		= GENL_ID_GENERATE,
> +	.hdrsize	= FIELD_SIZEOF(struct tbt_nhi_ctxt, id),
> +	.name		= NHI_GENL_NAME,
> +	.version	= NHI_GENL_VERSION,
> +	.maxattr	= NHI_ATTR_MAX,
> +};
> +
> +static LIST_HEAD(controllers_list);
> +static DECLARE_RWSEM(controllers_list_rwsem);
> +static atomic_t subscribers = ATOMIC_INIT(0);
> +static u32 portid;
> +
> +static bool nhi_nvm_authenticated(struct tbt_nhi_ctxt *nhi_ctxt)
> +{
> +	enum icm_operation_mode op_mode;
> +	u32 *msg_head, port_id, reg;
> +	struct sk_buff *skb;
> +	int i;
> +
> +	if (!nhi_ctxt->nvm_auth_on_boot)
> +		return true;
> +
> +	for (i = 0; i < 5; i++) {

5 is a magic number.

> +		u32 status;
> +
> +		status = ioread32(nhi_ctxt->iobase + REG_FW_STS);

So, can be registers represented as IO ports? Otherwise use plain
writel() / readl() and friends.

> +
> +		if (status & REG_FW_STS_NVM_AUTH_DONE)
> +			break;

> +		msleep(30);

Definitely needs comment why this is here.


> +	}
> +	/*
> +	 * The check for authentication is done after checking if iCM
> +	 * is present so it shouldn't reach the max tries (=5).
> +	 * Anyway, the check for full functionality below covers the
> error case.
> +	 */
> +	reg = ioread32(nhi_ctxt->iobase + REG_OUTMAIL_CMD);
> +	op_mode = (reg & REG_OUTMAIL_CMD_OP_MODE_MASK) >>
> +		  REG_OUTMAIL_CMD_OP_MODE_SHIFT;
> +	if (op_mode == FULL_FUNCTIONALITY)
> +		return true;
> +
> +	dev_warn(&nhi_ctxt->pdev->dev, "controller id %#x is in
> operation mode %#x status %#lx\n",
> +		 nhi_ctxt->id, op_mode,
> +		 (reg &
> REG_OUTMAIL_CMD_STS_MASK)>>REG_OUTMAIL_CMD_STS_SHIFT);

Spaces are missed around >>.

> +
> +	skb = genlmsg_new(NLMSG_ALIGN(nhi_genl_family.hdrsize),
> GFP_KERNEL);
> +	if (!skb) {
> +		dev_err(&nhi_ctxt->pdev->dev, "genlmsg_new failed:
> not enough memory to send controller operational mode\n");

Message can be located on the next line.

> +		return false;
> +	}
> +
> +	/* keeping port_id into a local variable for next use */

keeping -> Keeping

> +	port_id = portid;
> +	msg_head = genlmsg_put(skb, port_id, 0, &nhi_genl_family, 0,
> +			       NHI_CMD_ICM_IN_SAFE_MODE);
> +	if (!msg_head) {
> +		nlmsg_free(skb);
> +		dev_err(&nhi_ctxt->pdev->dev, "genlmsg_put failed:
> not enough memory to send controller operational mode\n");

Message can be located on the next line.

> +		return false;
> +	}
> +

>  static int __init nhi_init(void)
>  {
> -	if (!dmi_match(DMI_BOARD_VENDOR, "Apple Inc."))
> -		return -ENOSYS;
> -	return pci_register_driver(&nhi_driver);
> +	int rc = nhi_genl_register();
> +
> +	if (rc)
> +		goto failure;
> +
> +	rc = pci_register_driver(&nhi_driver);
> +	if (rc)
> +		goto failure_genl;
> +
> +	return 0;
> +
> +failure_genl:
> +	nhi_genl_unregister();
> +
> +failure:

> +	pr_debug("nhi: error %d occurred in %s\n", rc, __func__);

Doesn't make much sense. We have a mechanism to get this code and
function printed.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
