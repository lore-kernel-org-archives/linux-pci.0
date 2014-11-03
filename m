Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <545807ED.5090804@numascale.com>
Date: Tue, 04 Nov 2014 06:55:41 +0800
From: Daniel J Blueman <daniel@numascale.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Steffen Persvold <sp@numascale.com>
Subject: Re: [PATCH v3 3/5] Numachip: Add safe is-present function
References: <1414915813-2462-1-git-send-email-daniel@numascale.com> <1414915813-2462-3-git-send-email-daniel@numascale.com> <alpine.DEB.2.11.1411032044590.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1411032044590.5308@nanos>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/04/2014 03:45 AM, Thomas Gleixner wrote:
> On Sun, 2 Nov 2014, Daniel J Blueman wrote:
>
>> Add safe function to check if Numachip is detected, to be used elsewhere.
>
> I cannot find a use case for this. I guess this is a left over of the
> earlier 2G change, right?

I left it in as it's common to apic_numachip.c and a Numachip2 patch 
series I'll present later.

Daniel
-- 
Daniel J Blueman
Principal Software Engineer, Numascale
