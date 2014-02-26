Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:57061 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748AbaBZGbn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 01:31:43 -0500
Message-ID: <530D8A40.2070707@st.com>
Date: Wed, 26 Feb 2014 12:01:28 +0530
From: Ajay Khandelwal <ajay.khandelwal@st.com>
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI:designware:Fix iATU programming for cfg1, io
 and mem viewport
References: <17773172.14231392946292058.JavaMail.weblogic@epml01> <5306E3FE.1070405@ti.com>
In-Reply-To: <5306E3FE.1070405@ti.com>
Content-Type: text/plain; charset="EUC-KR"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On 2/21/2014 10:58 AM, Kishon Vijay Abraham I wrote:
> Thanks for the patch. I have just burnt my PCIE-to-PCI bridge card :-s Will
> test this once I get a new card.

were you able to solve issue in PCIE-to-PCI bridge.

On SPEAr I see issues with PCIe to PCI bridge and PCIe to PCIe switch.

Imprecise external abort is generated, providing hook for abort(similar
to imx6) solves this.

Thanks and Regards,
Ajay
