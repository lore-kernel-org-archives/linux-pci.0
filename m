Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1401182225170.776@be1.lrz>
References: <alpine.DEB.2.02.1401182225170.776@be1.lrz>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 14 Apr 2014 15:34:16 -0600
Message-ID: <CAErSpo7LCx_eakiiOjOcQwojQnFEcvJfeDUVFfMCGN-vbrSdSg@mail.gmail.com>
Subject: Re: [Bug 68591] - Please help debugging
To: 7eggert@gmx.de
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 18, 2014 at 3:59 PM,  <7eggert@gmx.de> wrote:
> Hi,
>
> I need some help debugging and possibly fixing this bug. E.g. "do
> bisecting in spite of the big version difference" or "use these debugging
> parameters".
>
> https://bugzilla.kernel.org/show_bug.cgi?id=68591
> "Regression: Asrock M3A UCC does not boot without acpi=off or pci=noacpi"
>
> thanks in advance
>         Bodo Eggert

Hi Bodo,

Any chance you could try the patch attached to that bugzilla?
(https://bugzilla.kernel.org/attachment.cgi?id=130681)

I think it should fix the problem you're seeing.

Bjorn
