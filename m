Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Thu, 3 Mar 2016 10:02:06 -0800
Message-ID: <CA+55aFzSYEvcGsGqCzEsaF7zU_gHyxejNW5XaoW9UrVOAV7E9A@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] PCI: Rework shadow ROM handling
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Lutomirski <luto@amacapital.net>,
	=?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 3, 2016 at 8:53 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> The purpose of this series is to:
> [ .. ]

The patches look ok to me and seem to make sense.

Of course, let's see what they break. Hopefully nothing, but any time
the PCI resource code changes I get a bit worried. PTSD, I guess.

                   Linus
