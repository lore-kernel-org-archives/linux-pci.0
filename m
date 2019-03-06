Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8267DC43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 20:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3233320657
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 20:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKGMlZ8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCFUoI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:44:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44142 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCFUoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2019 15:44:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id q128so12139726ljb.11;
        Wed, 06 Mar 2019 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKlrfvFiZEKKgT0ufDfDRXOR26Oz7UIKTJhyMVkTIYQ=;
        b=uKGMlZ8jBCQPEhrNYlRjHPUlMJHnet8sCrjCXNrY6m2uAm1gSa9OEJsePSmDABToLg
         9WSZM1yQr8wFPH+UAnse0n8k2oq0CvOvaIcDYm5m3Ea/5mvEDuaGV9cU9Uhk/sztt90d
         XFdVsjvFFafh1ZtAS7rZgD+/gyxRxPG5zaCX7ww3Ld1YKIdMeWBhBtg/0YMz50A0lm56
         7mKsp4RJe098UTU9PbnCbLQH15Pjc+f4XNrf3fP+erlD73l/X4F0Q9fMH3/KRbXGAf+V
         53jvnN2phU0ZvCp+dpQUIS5Z4p2YMZ855S0oWHt5WxvTkEw71tYik5oDn+dDGlFScWEN
         dLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qKlrfvFiZEKKgT0ufDfDRXOR26Oz7UIKTJhyMVkTIYQ=;
        b=Sv/o7/D4WfhSfiGV6u3UCBHFw8hucYGi0z2v61TSqJ7w+YaWleYA48Jh1P7s2HCLAn
         p41Mu71MEykA9nH/8tfzCmsZsu/kbIU0eCm+j4FE3hjPww6aiu99riHbOPOUWS+1QAge
         tQMWSJi6NEj7Y5YpM5/yFWvTEnMjPm0Sjj9iBKpe2iumV9XT5nVKXtWlFT2OOJjsSxVT
         TlJVRlSNy8Dj59WrisaBzu9RFf9YVBkCzRD+O3cqAreWtRVOkP7hOh8QEg8hsM4qjI3p
         DcH1KIFwMXoAzsqAMhPN7/BHL1WsWldrmxXv0bN/NIvcSuSU9w3Pt42Id0cYbWHA6PM8
         3erw==
X-Gm-Message-State: APjAAAUpOdayyeI/PUf6OUOUe31mKgY/AyvcPc9NMls3VKIeeNd/8T4c
        enYNCk9yu4+i2q7cxeRSVwM=
X-Google-Smtp-Source: APXvYqwaRHNcShYilVCHk2fYejOLd+QfkWuzv9hJYd1GqqlvfkNeYslsDCPlS0pMrDz7lrXo5Lv6Yg==
X-Received: by 2002:a2e:9105:: with SMTP id m5mr3699162ljg.100.1551905044429;
        Wed, 06 Mar 2019 12:44:04 -0800 (PST)
Received: from mobilestation ([95.79.187.182])
        by smtp.gmail.com with ESMTPSA id p3sm485173lfc.64.2019.03.06.12.44.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 06 Mar 2019 12:44:03 -0800 (PST)
Date:   Wed, 6 Mar 2019 23:44:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>
Subject: Re: [PATCH v2 10/12] NTB: Introduce NTB MSI Test Client
Message-ID: <20190306204400.hzpizimya7fq6swi@mobilestation>
Mail-Followup-To: Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
        Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190213175454.7506-11-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213175454.7506-11-logang@deltatee.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On Wed, Feb 13, 2019 at 10:54:52AM -0700, Logan Gunthorpe wrote:
> Introduce a tool to test NTB MSI interrupts similar to the other
> NTB test tools. This tool creates a debugfs directory for each
> NTB device with the following files:
> 
> port
> irqX_occurrences
> peerX/port
> peerX/count
> peerX/trigger
> 
> The 'port' file tells the user the local port number and the
> 'occurrences' files tell the number of local interrupts that
> have been received for each interrupt.
> 
> For each peer, the 'port' file and the 'count' file tell you the
> peer's port number and number of interrupts respectively. Writing
> the interrupt number to the 'trigger' file triggers the interrupt
> handler for the peer which should increment their corresponding
> 'occurrences' file. The 'ready' file indicates if a peer is ready,
> writing to this file blocks until it is ready.
> 
> The module parameter num_irqs can be used to set the number of
> local interrupts. By default this is 4. This is only limited by
> the number of unused MSI interrupts registered by the hardware
> (this will require support of the hardware driver) and there must
> be at least 2*num_irqs + 1 spads registers available.
> 

Alas the test driver is not going to work with IDT NTB hardware,
since it uses Spad only, which aren't supported by IDT devices. IDT NTB
PCIe functions provide message registers to communicate with peers. See
ntb_perf driver code for reference of portable driver design.

In order to make the test driver portable the following alterations
are needed:
1) Add NTB Message register API usage together with Scratchpad+Doorbell.
2) When NTB MSI library is updated with functions like
ntb_msi_peer_setup_mws()/ntb_msi_peer_clear_mws() they are needed to be
utilized in the test driver as well to set a translation address on the
peer side.

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> ---
>  drivers/ntb/test/Kconfig        |   9 +
>  drivers/ntb/test/Makefile       |   1 +
>  drivers/ntb/test/ntb_msi_test.c | 433 ++++++++++++++++++++++++++++++++
>  3 files changed, 443 insertions(+)
>  create mode 100644 drivers/ntb/test/ntb_msi_test.c
> 
> diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
> index a5d0eda44438..a3f3e2638935 100644
> --- a/drivers/ntb/test/Kconfig
> +++ b/drivers/ntb/test/Kconfig
> @@ -25,3 +25,12 @@ config NTB_PERF
>  	 to and from the window without additional software interaction.
>  
>  	 If unsure, say N.
> +
> +config NTB_MSI_TEST
> +	tristate "NTB MSI Test Client"
> +	depends on NTB_MSI
> +	help
> +	  This tool demonstrates the use of the NTB MSI library to
> +	  send MSI interrupts between peers.
> +
> +	  If unsure, say N.
> diff --git a/drivers/ntb/test/Makefile b/drivers/ntb/test/Makefile
> index 9e77e0b761c2..d2895ca995e4 100644
> --- a/drivers/ntb/test/Makefile
> +++ b/drivers/ntb/test/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_NTB_PINGPONG) += ntb_pingpong.o
>  obj-$(CONFIG_NTB_TOOL) += ntb_tool.o
>  obj-$(CONFIG_NTB_PERF) += ntb_perf.o
> +obj-$(CONFIG_NTB_MSI_TEST) += ntb_msi_test.o
> diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> new file mode 100644
> index 000000000000..99d826ed9c34
> --- /dev/null
> +++ b/drivers/ntb/test/ntb_msi_test.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +
> +#include <linux/module.h>
> +#include <linux/debugfs.h>
> +#include <linux/ntb.h>
> +#include <linux/pci.h>
> +#include <linux/radix-tree.h>
> +#include <linux/workqueue.h>
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_VERSION("0.1");
> +MODULE_AUTHOR("Logan Gunthorpe <logang@deltatee.com>");
> +MODULE_DESCRIPTION("Test for sending MSI interrupts over an NTB memory window");
> +
> +static int num_irqs = 4;
> +module_param(num_irqs, int, 0644);
> +MODULE_PARM_DESC(num_irqs, "number of irqs to use");
> +
> +struct ntb_msit_ctx {
> +	struct ntb_dev *ntb;
> +	struct dentry *dbgfs_dir;
> +	struct work_struct setup_work;
> +
> +	struct ntb_msit_isr_ctx {
> +		int irq_idx;
> +		int irq_num;
> +		int occurrences;
> +		struct ntb_msit_ctx *nm;
> +		struct ntb_msi_desc desc;
> +	} *isr_ctx;
> +
> +	struct ntb_msit_peer {
> +		struct ntb_msit_ctx *nm;
> +		int pidx;
> +		int num_irqs;
> +		struct completion init_comp;
> +		struct ntb_msi_desc *msi_desc;
> +	} peers[];
> +};
> +
> +static struct dentry *ntb_msit_dbgfs_topdir;
> +
> +static irqreturn_t ntb_msit_isr(int irq, void *dev)
> +{
> +	struct ntb_msit_isr_ctx *isr_ctx = dev;
> +	struct ntb_msit_ctx *nm = isr_ctx->nm;
> +
> +	dev_dbg(&nm->ntb->dev, "Interrupt Occurred: %d",
> +		isr_ctx->irq_idx);
> +
> +	isr_ctx->occurrences++;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void ntb_msit_setup_work(struct work_struct *work)
> +{
> +	struct ntb_msit_ctx *nm = container_of(work, struct ntb_msit_ctx,
> +					       setup_work);
> +	int irq_count = 0;
> +	int irq;
> +	int ret;
> +	uintptr_t i;
> +
> +	ret = ntb_msi_setup_mws(nm->ntb);
> +	if (ret) {
> +		dev_err(&nm->ntb->dev, "Unable to setup MSI windows: %d\n",
> +			ret);
> +		return;
> +	}
> +
> +	for (i = 0; i < num_irqs; i++) {
> +		nm->isr_ctx[i].irq_idx = i;
> +		nm->isr_ctx[i].nm = nm;
> +
> +		if (!nm->isr_ctx[i].irq_num) {
> +			irq = ntbm_msi_request_irq(nm->ntb, ntb_msit_isr,
> +						   KBUILD_MODNAME,
> +						   &nm->isr_ctx[i],
> +						   &nm->isr_ctx[i].desc);
> +			if (irq < 0)
> +				break;
> +
> +			nm->isr_ctx[i].irq_num = irq;
> +		}
> +
> +		ret = ntb_spad_write(nm->ntb, 2 * i + 1,
> +				     nm->isr_ctx[i].desc.addr_offset);
> +		if (ret)
> +			break;
> +
> +		ret = ntb_spad_write(nm->ntb, 2 * i + 2,
> +				     nm->isr_ctx[i].desc.data);
> +		if (ret)
> +			break;
> +
> +		irq_count++;
> +	}
> +
> +	ntb_spad_write(nm->ntb, 0, irq_count);
> +	ntb_peer_db_set(nm->ntb, BIT(ntb_port_number(nm->ntb)));
> +}
> +
> +static void ntb_msit_desc_changed(void *ctx)
> +{
> +	struct ntb_msit_ctx *nm = ctx;
> +	int i;
> +
> +	dev_dbg(&nm->ntb->dev, "MSI Descriptors Changed\n");
> +
> +	for (i = 0; i < num_irqs; i++) {
> +		ntb_spad_write(nm->ntb, 2 * i + 1,
> +			       nm->isr_ctx[i].desc.addr_offset);
> +		ntb_spad_write(nm->ntb, 2 * i + 2,
> +			       nm->isr_ctx[i].desc.data);
> +	}
> +
> +	ntb_peer_db_set(nm->ntb, BIT(ntb_port_number(nm->ntb)));
> +}
> +
> +static void ntb_msit_link_event(void *ctx)
> +{
> +	struct ntb_msit_ctx *nm = ctx;
> +
> +	if (!ntb_link_is_up(nm->ntb, NULL, NULL))
> +		return;
> +
> +	schedule_work(&nm->setup_work);
> +}
> +
> +static void ntb_msit_copy_peer_desc(struct ntb_msit_ctx *nm, int peer)
> +{
> +	int i;
> +	struct ntb_msi_desc *desc = nm->peers[peer].msi_desc;
> +	int irq_count = nm->peers[peer].num_irqs;
> +
> +	for (i = 0; i < irq_count; i++) {
> +		desc[i].addr_offset = ntb_peer_spad_read(nm->ntb, peer,
> +							 2 * i + 1);
> +		desc[i].data = ntb_peer_spad_read(nm->ntb, peer, 2 * i + 2);
> +	}
> +
> +	dev_info(&nm->ntb->dev, "Found %d interrupts on peer %d\n",
> +		 irq_count, peer);
> +
> +	complete_all(&nm->peers[peer].init_comp);
> +}
> +
> +static void ntb_msit_db_event(void *ctx, int vec)
> +{
> +	struct ntb_msit_ctx *nm = ctx;
> +	struct ntb_msi_desc *desc;
> +	u64 peer_mask = ntb_db_read(nm->ntb);
> +	u32 irq_count;
> +	int peer;
> +
> +	ntb_db_clear(nm->ntb, peer_mask);
> +
> +	for (peer = 0; peer < sizeof(peer_mask) * 8; peer++) {
> +		if (!(peer_mask & BIT(peer)))
> +			continue;
> +
> +		irq_count = ntb_peer_spad_read(nm->ntb, peer, 0);
> +		if (irq_count == -1)
> +			continue;
> +
> +		desc = kcalloc(irq_count, sizeof(*desc), GFP_ATOMIC);
> +		if (!desc)
> +			continue;
> +
> +		kfree(nm->peers[peer].msi_desc);
> +		nm->peers[peer].msi_desc = desc;
> +		nm->peers[peer].num_irqs = irq_count;
> +
> +		ntb_msit_copy_peer_desc(nm, peer);
> +	}
> +}
> +
> +static const struct ntb_ctx_ops ntb_msit_ops = {
> +	.link_event = ntb_msit_link_event,
> +	.db_event = ntb_msit_db_event,
> +};
> +
> +static int ntb_msit_dbgfs_trigger(void *data, u64 idx)
> +{
> +	struct ntb_msit_peer *peer = data;
> +
> +	if (idx >= peer->num_irqs)
> +		return -EINVAL;
> +
> +	dev_dbg(&peer->nm->ntb->dev, "trigger irq %llu on peer %u\n",
> +		idx, peer->pidx);
> +
> +	return ntb_msi_peer_trigger(peer->nm->ntb, peer->pidx,
> +				    &peer->msi_desc[idx]);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_trigger_fops, NULL,
> +			 ntb_msit_dbgfs_trigger, "%llu\n");
> +
> +static int ntb_msit_dbgfs_port_get(void *data, u64 *port)
> +{
> +	struct ntb_msit_peer *peer = data;
> +
> +	*port = ntb_peer_port_number(peer->nm->ntb, peer->pidx);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_port_fops, ntb_msit_dbgfs_port_get,
> +			 NULL, "%llu\n");
> +
> +static int ntb_msit_dbgfs_count_get(void *data, u64 *count)
> +{
> +	struct ntb_msit_peer *peer = data;
> +
> +	*count = peer->num_irqs;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_count_fops, ntb_msit_dbgfs_count_get,
> +			 NULL, "%llu\n");
> +
> +static int ntb_msit_dbgfs_ready_get(void *data, u64 *ready)
> +{
> +	struct ntb_msit_peer *peer = data;
> +
> +	*ready = try_wait_for_completion(&peer->init_comp);
> +
> +	return 0;
> +}
> +
> +static int ntb_msit_dbgfs_ready_set(void *data, u64 ready)
> +{
> +	struct ntb_msit_peer *peer = data;
> +
> +	return wait_for_completion_interruptible(&peer->init_comp);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_ready_fops, ntb_msit_dbgfs_ready_get,
> +			 ntb_msit_dbgfs_ready_set, "%llu\n");
> +
> +static int ntb_msit_dbgfs_occurrences_get(void *data, u64 *occurrences)
> +{
> +	struct ntb_msit_isr_ctx *isr_ctx = data;
> +
> +	*occurrences = isr_ctx->occurrences;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_occurrences_fops,
> +			 ntb_msit_dbgfs_occurrences_get,
> +			 NULL, "%llu\n");
> +
> +static int ntb_msit_dbgfs_local_port_get(void *data, u64 *port)
> +{
> +	struct ntb_msit_ctx *nm = data;
> +
> +	*port = ntb_port_number(nm->ntb);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_local_port_fops,
> +			 ntb_msit_dbgfs_local_port_get,
> +			 NULL, "%llu\n");
> +
> +static void ntb_msit_create_dbgfs(struct ntb_msit_ctx *nm)
> +{
> +	struct pci_dev *pdev = nm->ntb->pdev;
> +	char buf[32];
> +	int i;
> +	struct dentry *peer_dir;
> +
> +	nm->dbgfs_dir = debugfs_create_dir(pci_name(pdev),
> +					   ntb_msit_dbgfs_topdir);
> +	debugfs_create_file("port", 0400, nm->dbgfs_dir, nm,
> +			    &ntb_msit_local_port_fops);
> +
> +	for (i = 0; i < ntb_peer_port_count(nm->ntb); i++) {
> +		nm->peers[i].pidx = i;
> +		nm->peers[i].nm = nm;
> +		init_completion(&nm->peers[i].init_comp);
> +
> +		snprintf(buf, sizeof(buf), "peer%d", i);
> +		peer_dir = debugfs_create_dir(buf, nm->dbgfs_dir);
> +
> +		debugfs_create_file_unsafe("trigger", 0200, peer_dir,
> +					   &nm->peers[i],
> +					   &ntb_msit_trigger_fops);
> +
> +		debugfs_create_file_unsafe("port", 0400, peer_dir,
> +					   &nm->peers[i], &ntb_msit_port_fops);
> +
> +		debugfs_create_file_unsafe("count", 0400, peer_dir,
> +					   &nm->peers[i],
> +					   &ntb_msit_count_fops);
> +
> +		debugfs_create_file_unsafe("ready", 0600, peer_dir,
> +					   &nm->peers[i],
> +					   &ntb_msit_ready_fops);
> +	}
> +
> +	for (i = 0; i < num_irqs; i++) {
> +		snprintf(buf, sizeof(buf), "irq%d_occurrences", i);
> +		debugfs_create_file_unsafe(buf, 0400, nm->dbgfs_dir,
> +					   &nm->isr_ctx[i],
> +					   &ntb_msit_occurrences_fops);
> +	}
> +}
> +
> +static void ntb_msit_remove_dbgfs(struct ntb_msit_ctx *nm)
> +{
> +	debugfs_remove_recursive(nm->dbgfs_dir);
> +}
> +
> +static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
> +{
> +	struct ntb_msit_ctx *nm;
> +	size_t struct_size;
> +	int peers;
> +	int ret;
> +
> +	peers = ntb_peer_port_count(ntb);
> +	if (peers <= 0)
> +		return -EINVAL;
> +
> +	if (ntb_spad_is_unsafe(ntb) || ntb_spad_count(ntb) < 2 * num_irqs + 1) {
> +		dev_err(&ntb->dev, "NTB MSI test requires at least %d spads for %d irqs\n",
> +			2 * num_irqs + 1, num_irqs);
> +		return -EFAULT;
> +	}
> +
> +	ret = ntb_spad_write(ntb, 0, -1);
> +	if (ret) {
> +		dev_err(&ntb->dev, "Unable to write spads: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ntb_db_clear_mask(ntb, GENMASK(peers - 1, 0));
> +	if (ret) {
> +		dev_err(&ntb->dev, "Unable to clear doorbell mask: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ntb_msi_init(ntb, ntb_msit_desc_changed);
> +	if (ret) {
> +		dev_err(&ntb->dev, "Unable to initialize MSI library: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	struct_size = sizeof(*nm) + sizeof(*nm->peers) * peers;
> +
> +	nm = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
> +	if (!nm)
> +		return -ENOMEM;
> +
> +	nm->isr_ctx = devm_kcalloc(&ntb->dev, num_irqs, sizeof(*nm->isr_ctx),
> +				   GFP_KERNEL);
> +	if (!nm->isr_ctx)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&nm->setup_work, ntb_msit_setup_work);
> +	nm->ntb = ntb;
> +
> +	ntb_msit_create_dbgfs(nm);
> +
> +	ret = ntb_set_ctx(ntb, nm, &ntb_msit_ops);
> +	if (ret)
> +		goto remove_dbgfs;
> +
> +	if (!nm->isr_ctx)
> +		goto remove_dbgfs;
> +
> +	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> +
> +	return 0;
> +
> +remove_dbgfs:
> +	ntb_msit_remove_dbgfs(nm);
> +	devm_kfree(&ntb->dev, nm->isr_ctx);
> +	devm_kfree(&ntb->dev, nm);
> +	return ret;
> +}
> +
> +static void ntb_msit_remove(struct ntb_client *client, struct ntb_dev *ntb)
> +{
> +	struct ntb_msit_ctx *nm = ntb->ctx;
> +	int i;
> +
> +	ntb_link_disable(ntb);
> +	ntb_db_set_mask(ntb, ntb_db_valid_mask(ntb));
> +	ntb_msi_clear_mws(ntb);
> +
> +	for (i = 0; i < ntb_peer_port_count(ntb); i++)
> +		kfree(nm->peers[i].msi_desc);
> +
> +	ntb_clear_ctx(ntb);
> +	ntb_msit_remove_dbgfs(nm);
> +}
> +
> +static struct ntb_client ntb_msit_client = {
> +	.ops = {
> +		.probe = ntb_msit_probe,
> +		.remove = ntb_msit_remove
> +	}
> +};
> +
> +static int __init ntb_msit_init(void)
> +{
> +	int ret;
> +
> +	if (debugfs_initialized())
> +		ntb_msit_dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME,
> +							   NULL);
> +
> +	ret = ntb_register_client(&ntb_msit_client);
> +	if (ret)
> +		debugfs_remove_recursive(ntb_msit_dbgfs_topdir);
> +
> +	return ret;
> +}
> +module_init(ntb_msit_init);
> +
> +static void __exit ntb_msit_exit(void)
> +{
> +	ntb_unregister_client(&ntb_msit_client);
> +	debugfs_remove_recursive(ntb_msit_dbgfs_topdir);
> +}
> +module_exit(ntb_msit_exit);
> -- 
> 2.19.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20190213175454.7506-11-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
