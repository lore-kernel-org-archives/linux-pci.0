Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18694 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab3LEInD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 03:43:03 -0500
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Yinghai Lu' <yinghai@kernel.org>
CC: Pratyush Anand <pratyush.anand@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Stephen Warren" <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	"Krishna Thota" <kthota@nvidia.com>
Date: Thu, 5 Dec 2013 14:11:22 +0530
Subject: RE: [Discussion]: ARM: PCIE: Setup bridges not happening with
 portbus driver enabled
Message-ID: <C79B248886DD134989C8FF6B096A91AB92139701CA@BGMAIL01.nvidia.com>
References: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
	<20131205064822.GB2298@pratyush-vbox>
	<C79B248886DD134989C8FF6B096A91AB92139701C9@BGMAIL01.nvidia.com>
 <CAE9FiQUqnSYFnmETkJcSeFh=5S9Qh5XsCuvA1YoXkU4608cXmQ@mail.gmail.com>
In-Reply-To: <CAE9FiQUqnSYFnmETkJcSeFh=5S9Qh5XsCuvA1YoXkU4608cXmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >> Does your RC driver calls pci_assign_unassigned_resources after
> >> pci_common_init?
> >>
> > No it does not. Btw, I tried calling it but it also did not help and same
> problem.
> 
> Please make sure you pci_assign_unassigned_resources get called via
> fs_initcall().
> 
Calling fs_initcall(pci_assign_unassigned_resources)  just after pci_common_init also did not help.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
