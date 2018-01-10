Return-Path: <SRS0=72TD=EF=amd.com=Christian.Koenig@kernel.org>
Return-Path: <SRS0=72TD=EF=amd.com=Christian.Koenig@kernel.org>
Subject: Re: [BISECTED] v4.15-rc: Boot regression on x86_64/AMD
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@linux.ie>
References: <20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi>
 <CA+55aFxCSWCG7ZvHW3AkLPzMPMAuG1BhL8fNgC0-JPYU4LZVow@mail.gmail.com>
 <CAErSpo7dOfabXk9rpZr=B87wK4_Ao9_moK89Ze0cyi6Mqb0Z+Q@mail.gmail.com>
 <628e2b58-b16b-5792-b4ef-88bec15ab779@amd.com>
 <20180109183856.GD31640@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <773c150c-a9e6-1246-50ee-2c468490db95@amd.com>
Date: Wed, 10 Jan 2018 13:29:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180109183856.GD31640@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 09.01.2018 um 19:38 schrieb Bjorn Helgaas:
> I don't like to add new parameters because I think it's an
> unreasonable burden on users and it makes it hard for distros, but I
> understand the desire to use this functionality.  What would you think
> of adding a "pci=big_root_window" parameter that logs an info message
> and taints the kernel with TAINT_FIRMWARE_WORKAROUND?  Then there's at
> least some clue that we're in uncharted territory.

Done, patches for this are in your inbox.

Additionally to that I cleaned up the 256GB patch a bit more, e.g. added 
a comment where the 0xfd00000000 limit comes from and updated the commit 
message.

Please review and/or comment,
Christian.
