Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:51800 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbbA0QvJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 11:51:09 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so12945204qcw.9
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2015 08:51:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54C5EF11.8070604@desy.de>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
 <CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com>
 <CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
 <CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com>
 <CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com>
 <20150122222016.GF13072@google.com> <CAH9N0t_YoRZtPqWwAaNdHNW3m-HOfrCevBZGiOnM+VWGxeFwEQ@mail.gmail.com>
 <CAErSpo4bRnGkfmzLnGSUnv-aJfmZLtQ_jXhnZo+9Wm=CgHOB3A@mail.gmail.com> <54C5EF11.8070604@desy.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 27 Jan 2015 10:50:47 -0600
Message-ID: <CAErSpo4EeEAA-ci1EfSKNijUJA_4uLMu+WU7ORpQPeR9T9Rr8g@mail.gmail.com>
Subject: Re: Hot add a PCIe device driver upon hotplug event
To: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Cc: Paulo Fortuna Carvalho <pricardofc@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ludwig,

Thanks a lot for the pointers to MTCA information.  I found
presentation slides here:
https://indico.desy.de/getFile.py/access?contribId=33&sessionId=0&resId=1&materialId=slides&confId=10329,
which I assume is that you're referring to.

On Mon, Jan 26, 2015 at 1:38 AM, Ludwig Petrosyan
<ludwig.petrosyan@desy.de> wrote:
>
> Hello
>
> (I have send this email two days ago but got status undeliverable, so try to
> send it again)
>
> We had the same problem on the MTCA system years ago, but now the problem is
> solved.
> The MTCA system is a kind of ATCA and I think attention Button problem could
> be solved in the same way.
> Ok, now what we have done:
> First of all the main difference of the ATCA or MTCA PCIe system is what the
> PCIe Switch which responsible for the HotPlug
>
> (I mean Switch which is connected to the crate slots, and hotplug
> controllers of this are used in hotpluging ) and the Attention Button of the
>
> PCIe slot reside on the different boards (usually PCIe Switch is on the
> Crate Manager  board and Attention Button is  the AMC module Latch ),
>
> So there are no any wired connections between Attention Button and PCIe
> Switch. Than user pool out the AMC module Latch the PCIe Switch has no idea
>
> about that, BUT the AMC module controller (MMC) sends IPMI message to the
> Crate Management Controller (MCMC)
> and MCMC starts AMC powering down procedures. The idea was: usually MCMC and
> PCIe Switch reside on the same board and MCMC getting IPMI message
>
> about state change of the AMC Latch (latch polled out or pressed) set
> appropriate registers of the PCIe Switch or push high appropriate lines of
> the PCIe Switch
>
> and PCIe Switch gets information that Attention Button is pressed and send
> hotplug interrupt to the hotplug driver.
> This approach works in our MTCA systems and we have a full working PCIe
> HotPlug.

It sounds like you basically have some IPMI glue between the the AMC
latch and the PCIe Attention Button, and from the point of view of the
pciehp (PCIe native hotplug) driver, it just sees a normal Attention
Button.  That sounds like a reasonable thing to do.

In Paulo's case, it sounds like there is some sort of switch related
to the card, but the IPMI or similar glue that could potentially lead
to the Attention Button line doesn't exist.  In that case, pciehp
doesn't know anything about the switch.  If there's some other way,
e.g., IPMI, to learn about the switch, maybe that could be done via a
separate driver.

> More detailed information one can get to look documents of the MTCA Workshop
> (http://mtcaws.desy.de/) in tutorial section was presentation about
>
> PCIe Hotplug, or look in PICMIG recommendation (there is new recommendation
> about PCIe HotPlug for MTC.4)
>
> With best regards
>
> Ludwig Petrosyan
>
>
