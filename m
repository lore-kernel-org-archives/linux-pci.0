Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Mar 2017 15:29:26 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/5] PCI: rockchip: add remove() support
Message-ID: <20170320222925.GA78325@google.com>
References: <20170310024617.67303-1-briannorris@chromium.org>
 <20170310024617.67303-3-briannorris@chromium.org>
 <de4d1e8a-c971-1f4d-2996-883341d287b3@rock-chips.com>
 <5cec190e-4eee-fc55-7039-2336ba5253f3@rock-chips.com>
 <20170310194011.GA16352@google.com>
 <e41ab95e-9f65-2822-1ec2-a02a4766d53d@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e41ab95e-9f65-2822-1ec2-a02a4766d53d@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 10:26:12AM +0800, Shawn Lin wrote:
> I just thought we should fix the domain number here by adding
> "linux,pci-domain = <0>" for rk3399.dtsi, which seems more wise
> to me now. Does it make sense to you?

I think that's fine (as noted in response to your patch). That doesn't
really prevent this from being a core PCI domain bug though...

BTW, I've been using this patch set to do some repeated remove/probe
testing, and aside from the domain renumbering question and a small
memory leak noticed by kmemleak (an existing bug; sending a patch
shortly), this has been working well for me.

Brian
