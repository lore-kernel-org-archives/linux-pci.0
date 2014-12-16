Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:39467 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbaLPAgN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Dec 2014 19:36:13 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so9375341qcz.38
        for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2014 16:36:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141216000821.GM11285@n2100.arm.linux.org.uk>
References: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141215235248.GA4374@google.com> <20141216000821.GM11285@n2100.arm.linux.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 15 Dec 2014 17:35:52 -0700
Message-ID: <CAErSpo7mH1DdJ9t+jb+3gy+gJiM03imfd27A7Sz_VkKovC=rhA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm: pcibios: remove pci_sys_data domain
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 15, 2014 at 5:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 15, 2014 at 04:52:48PM -0700, Bjorn Helgaas wrote:
>> I provisionally applied these to my next-pci/domain branch.  This will be
>> rebased after v3.19-rc1.
>>
>> I'd like to see acks from Thomas and/or Jason for MVEBU, and Simon for
>> R-Car.
>
> And you should also have my acked-by for the core ARM code:
>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Right, thanks!  Sorry I didn't notice that.
