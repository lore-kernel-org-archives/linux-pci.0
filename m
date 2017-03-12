Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 12 Mar 2017 12:57:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: lkml@pengaru.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, vcaputo@pengaru.com,
        linux-pci@vger.kernel.org
Subject: Re: [BUG] 4.11.0-rc1 panic on shutdown X61s
Message-ID: <20170312115703.GA18197@nazgul.tnic>
References: <20170312053723.GH802@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170312053723.GH802@shells.gnugeneration.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 11, 2017 at 09:37:23PM -0800, lkml@pengaru.com wrote:
> Hello list,
> 
> Here's a photo of the panic, on imgur to be kind to vger:
> http://imgur.com/a/wZI32
> 
> I'm out on a sailboat so can't really do much, but had a chance with internet

So you didn't bring another box with you on the sailboat to connect it to the
laptop over netconsole to catch full dmesg, did you?

:-)))

Because there's a taint W flag in that splat which means there was a
warning which fired before that. Which could be the important piece of
dmesg...

Other than that, this is the BUG() pci_msi_shutdown(). Hmm, maybe
linux-pci has an idea, CCed.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
