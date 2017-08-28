Return-Path: <SRS0=ZEMw=76=gmail.com=festevam@kernel.org>
Return-Path: <SRS0=ZEMw=76=gmail.com=festevam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1690109.dqujpfY2W8@phil>
References: <1503187634-3823-1-git-send-email-festevam@gmail.com>
 <20170824163323.GG31858@bhelgaas-glaptop.roam.corp.google.com> <1690109.dqujpfY2W8@phil>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 27 Aug 2017 21:27:15 -0300
Message-ID: <CAOMZO5Dh7Mxv-wePiQnW8VG5o=LeBZ1ZfUaPuHbnmqNoYW=3-g@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Use gpiod_set_value_cansleep() to allow
 reset via expanders
To: Heiko Stuebner <heiko@sntech.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 24, 2017 at 1:37 PM, Heiko Stuebner <heiko@sntech.de> wrote:

>> Waiting for Shawn's ack...
>
> we might want to include him then, as I'm not sure if he patrols the
> linux-pci list :-) . [I've added him]

Sorry, I missed to add Shawn on Cc. I have just resent the patch with him on Cc.

Thanks
