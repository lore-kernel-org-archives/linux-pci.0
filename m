Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <508D0ECA.8040008@mvista.com>
Date: Sun, 28 Oct 2012 14:54:02 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
CC: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pcmcia@lists.infradead.org, linux-scsi@vger.kernel.org,
	devel@open-fcoe.org, virtualization@lists.linux-foundation.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/16] treewide: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
References: <cover.1351411047.git.joe@perches.com>
In-Reply-To: <cover.1351411047.git.joe@perches.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 28-10-2012 12:05, Joe Perches wrote:

> dev_<level> create smaller objects than dev_printk(KERN_<LEVEL>.
> Convert non-debug calls to this form.

> Joe Perches (16):
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
[...]
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
[...]
>    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(

    Hm, somehow this patch is repeated thrice?

MBR, Sergei

