Return-Path: <SRS0=jRHk=46=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=jRHk=46=chromium.org=briannorris@kernel.org>
Date: Tue, 23 May 2017 18:15:07 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: check link status when validating device
Message-ID: <20170524011507.GA112603@google.com>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
 <20170523194443.GD7241@bhelgaas-glaptop.roam.corp.google.com>
 <c2331eef-b76d-720d-3750-6d754d53710a@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c2331eef-b76d-720d-3750-6d754d53710a@rock-chips.com>
List-ID: <linux-pci.vger.kernel.org>

(Since Shawn didn't quite answer this piece)

On Wed, May 24, 2017 at 09:04:33AM +0800, Shawn Lin wrote:
> 在 2017/5/24 3:44, Bjorn Helgaas 写道:
> >On Fri, May 19, 2017 at 02:58:27PM +0800, Shawn Lin wrote:
> >>This patch checks the link status before reading and
> >>writing configure space of devices attached to the RC.
> >>If the link status is down, we shouldn't try to access
> >>the devices.
> >
> >What bad things happen without this patch?

On this SoC, I've seen this sort of behavior (reading the config space
when the device isn't responding) yield aborts, which panic the system. 

I can't speak exactly for which scenarios Shawn is addressing though. As
I mentioned, this patch doesn't do anything for me so far.

Brian
