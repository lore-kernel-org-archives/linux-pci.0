Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Dec 2013 13:31:02 -0800
From: David Cohen <david.a.cohen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] x86: intel-mid: remove deprecated X86_MDFLD and
 X86_WANT_INTEL_MID configs
Message-ID: <20131216213102.GD17264@psi-dev26.jf.intel.com>
References: <1387224459-25746-1-git-send-email-david.a.cohen@linux.intel.com>
 <1387224459-25746-5-git-send-email-david.a.cohen@linux.intel.com>
 <CAErSpo5tM4nF-WuUb9CH6sZ+XJ3u_U5nwg9u2cbn0EmeG1OgLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5tM4nF-WuUb9CH6sZ+XJ3u_U5nwg9u2cbn0EmeG1OgLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Bjorn,

[snip]

> It'd be nice to know what "MID" means -- from Googling, I guess
> "Mobile Internet Device."

Yes, that's correct. Wikipedia explains it:
http://en.wikipedia.org/wiki/Mobile_Internet_device

I'll prepare a patch adding intel mid to Documentation/ as soon as I have
time for it.

Br, David Cohen

