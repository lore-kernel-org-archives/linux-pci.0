Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15203 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab3LEHiT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 02:38:19 -0500
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	"'yinghai@kernel.org'" <yinghai@kernel.org>,
	"Stephen Warren" <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	"Krishna Thota" <kthota@nvidia.com>
Date: Thu, 5 Dec 2013 13:08:14 +0530
Subject: RE: [Discussion]: ARM: PCIE: Setup bridges not happening with
 portbus driver enabled
Message-ID: <C79B248886DD134989C8FF6B096A91AB92139701C9@BGMAIL01.nvidia.com>
References: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
 <20131205064822.GB2298@pratyush-vbox>
In-Reply-To: <20131205064822.GB2298@pratyush-vbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Thu, Dec 05, 2013 at 01:44:53PM +0800, Jay Agarwal wrote:
> > Hi All,
> >
> > I am seeing below issue on an ARM platform with CONFIG_PCIEPORTBUS
> > enabled in kernel
> >
> > ISSUE:  Any memory access by devices fails
> >
> > FINDINGS:
> >
> > 1. No bridge windows like below are setup and probably this is not
> > allowing any memory access by devices
> 
> Does your RC driver calls pci_assign_unassigned_resources after
> pci_common_init?
> 
> Regards
> Pratyush
> 
No it does not. Btw, I tried calling it but it also did not help and same problem. 
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
