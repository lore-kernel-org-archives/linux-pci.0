Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:35588 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbESXWQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 19:22:16 -0400
Received: by qceb3 with SMTP id b3so14244003qce.2
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 16:22:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150519230532.GV31666@google.com>
References: <1430382149-1645-1-git-send-email-jszhang@marvell.com> <20150519230532.GV31666@google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 19 May 2015 18:21:55 -0500
Message-ID: <CAErSpo5usw095K=9-rcjpHoxZTsfAC+wov=03adk6+acitSUvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: designware: improve iATU programming and usage
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Pratyush Anand <pratyush.anand@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[-cc Mohit, +cc Pratyush]

On Tue, May 19, 2015 at 6:05 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Mohit]
>
> On Thu, Apr 30, 2015 at 04:22:27PM +0800, Jisheng Zhang wrote:
>> The outbound iATU programming functions are similar, so PATCH1 consolidates
>> them into one.
>>
>> Most transactions' type are cfg0 and MEM, so current iATU usage is not
>> balanced. PATCH2 adopts idea from Minghuan Lian <Minghuan.Lian@freescale.com>:
>>
>>  http://www.spinics.net/lists/linux-pci/msg40440.html
>>
>> to change the iATU allocation: iATU0 for cfg and IO, iATU1 for MEM.
>>
>> Changes since v1:
>> - remove outbound iATU programming for IO in dw_pcie_host_init, since it can
>>   be done by berlin_pcie_{rd|wr}_other_conf() latter.
>> - only do outbound iATU programming for MEM if pp->ops->rd_other_conf is not
>>   set. Thank Fabrice Gasnier to point out "some platforms doesn't have support
>>   for ATU"
>>
>> Jisheng Zhang (2):
>>   PCI: designware: consolidate outbound iATU programming functions
>>   PCI: designware: use iATU0 for cfg and IO, iATU1 for MEM
>>
>>  drivers/pci/host/pcie-designware.c | 142 ++++++++++++++++---------------------
>
> These need acks from Jingoo and/or Mohit.  Any opinions?

Oops, sorry, forgot about the recent addition of Pratyush.

Bjorn
