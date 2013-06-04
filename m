Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:48300 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab3FDVkI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2013 17:40:08 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so579069oag.32
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2013 14:40:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1085B9F73@SCYBEXDAG04.amd.com>
References: <1370255050-2358-1-git-send-email-shane.huang@amd.com>
 <51AC6A14.2040908@cogentembedded.com> <CAErSpo5Jh_znOjr0CRBN=Kay+Y2ZJ2dDfVJdVW7MW9TjFzB6Yg@mail.gmail.com>
 <43EB3AB3EEFE8D43B525F4D2EAF507E1085B9F73@SCYBEXDAG04.amd.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Jun 2013 15:39:47 -0600
Message-ID: <CAErSpo5omduEpNv-DC31FJYGM=R-QaNYDikcAKHNSHeTEf2YCA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/3] ahci: add AMD CZ SATA device ID
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Tejun Heo <tj@kernel.org>, Jean Delvare <khali@linux-fr.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 3, 2013 at 8:09 PM, Huang, Shane <Shane.Huang@amd.com> wrote:
> Bjorn,
>
>> Let me know if anybody objects.  Otherwise, I'll merge it into my
>> -next branch tomorrow.
>
> The change is fine with me, thanks to you and Sergei.

OK, all three are now in the PCI -next branch, headed for v3.11.

After removing the dependences on pci_ids.h, they could have gone
individually via i2c and ahci trees, but in the interest of getting on
with it, I just put them in.

Bjorn
