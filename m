Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33279 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdCVFtN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2017 01:49:13 -0400
MIME-Version: 1.0
Reply-To: linasvepstas@gmail.com
In-Reply-To: <1490102658-22768-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1490102658-22768-1-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Wed, 22 Mar 2017 13:48:51 +0800
Message-ID: <CAHrUA34WX1sqEWJiuiy8yN2B1NHjDzj5UQ2A=0Nsdad1cVNjDw@mail.gmail.com>
Subject: Re: [PATCH] pci-error-recovery: doc cleanup
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, Mar 21, 2017 at 9:24 PM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> Include whitespace shooting; correction; typo fix; superfluous word
> dropping.

>
> diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.txt
> index da3b217..0b6bb3e 100644
> --- a/Documentation/PCI/pci-error-recovery.txt
> +++ b/Documentation/PCI/pci-error-recovery.txt
>
> @@ -231,14 +231,14 @@ proceeds to STEP 4 (Slot Reset)
>  STEP 3: Link Reset
>  ------------------
>  The platform resets the link.  This is a PCI-Express specific step
> -and is done whenever a non-fatal error has been detected that can be
> +and is done whenever a fatal error has been detected that can be
>  "solved" by resetting the link.

First: I thought I saw a patch a few months ago that proposed removing
the link rest step.  I don't know if the patch was accepted or not.

If link resets are still supported, then they can only fix NON-fatal errors:
basically, one resets the link, and only the link; one does NOT reset
either the device driver, nor the device state. The idea is that after a link
reset, communications with the device can immediately resume right
where it left off. (this can be hard in practice, if the driver/firmware doesn't
know what it was doing when the error occurred.  this might be why no one
implements it.)  Anyway, the whole point of a link reset is that it is
explicitly
a non-fatal error.

--linas
