Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267026;
	b=s9U0O43g5NNNQ0L0fs2BDR+FiCXj/VyNarqPaESO/+GSPPGXbZ5odv8dx/ERPteNdkuK
	 OXb1c2omKcI64x6QkRa/24i+KuMB+Ch2cKfR79uiwChsThpbR4D9pRD+0k4xmX4uehyDb
	 tOhZ0c2Mopp/4xLoQapdOXcv+t6SklOnAJhc7+c0XvGp6IDYGUgjPijFLMiljTMTYIu0W
	 nxoDmZAp/KpCSvzF8agX+0ygexLnl7Xo6AQgir10AVTpQFM6FRDPfxrTWkroiP1qA2JmL
	 rshJWUi1popbtUqCiEjbu9jp6sFu0vCLFdYRBGrMu6LBqyghJSp5+Flu2joJoxrUi7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267026;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rDufbgU9DjjArVg6LYOFxMbFtdAImCMn0ES8uFPgnOQ=;
	b=zttjgnDfBjKidSt8IFDoQNdeqZfz9CQODlYteJiDHCvHrrSUrkC0ANQxPv8+8A3BnY0s
	 JBGdwTHbBoySwwS6pCnvsy7T04tgJz2YRcst84idTufCwq4nMFqlMR/dmX79thM52Ha1I
	 kuNBZHZDMR8S9Ghn4LiZND2Mnx4WQL8Ib5l54ErcmdxThwqN6Bmw82XPTHL8MNYkBEnVI
	 WrBsX8Ws/j6MKOPi+bQRrLl5+7+3iXLBn9xfNs4t9AQF7O7wL62ONklW04w8OomNjT+qc
	 ZMx9HiYIqaYhoODFd6SgpR5c/CjvlyOrCo6SPlTTgHpiVDWlTtSACWl13updi0sxhsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdYmwMWM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D4606A339;
	Mon,  9 Nov 2026 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdYmwMWM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230851F008A5;
	Mon,  9 Nov 2026 23:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267025;
	bh=rDufbgU9DjjArVg6LYOFxMbFtdAImCMn0ES8uFPgnOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=kdYmwMWMJqLuN46lAKr0eK2PIu6P70TX7SXz6Dq0517amU8TLpmYy+Z3D+PyD3WVQ
	 zwxxWsVOoxuSUfQ/hPX8FcKGwkbM7dfmIQ5ERc2h73BFWy5np83tn4llj6qrv7Oe4r
	 pi4mj0Rt0M9eeCEjIJZk6z43LupQR7m3U+L1AYQ6tShotAwHrJIbz9xg+9DlkFEBE+
	 pt4qZTJ6YwzZ1eDEnYhw7nxmo/YuzrjakdBQ2NCKhmIl7mypQMV+FwrfQIO9Rb1WX7
	 rzVgpUWWdgoLxBkwFn22DgM7HGez6fsdeoWC0aGTtjX0j8yiHPDE63x342w7TPAbdK
	 Q/MzJbbg9YpVQ==
Date: Mon, 9 Nov 2026 17:30:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cole Leavitt <cole@unwrap.rs>, Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <westeri@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Don't resume the software CM if the
 host controller is gone
Message-ID: <20261109233024.GA346916@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108051829.152803-1-cole@unwrap.rs>

On Sun, Nov 08, 2026 at 12:18:29AM -0500, Cole Leavitt wrote:
> Hi Mika,
> 
> On Mon, Oct 19, 2026 at 06:29:20AM +0200, Mika Westerberg wrote:
> > This is not supposed to happen with SW CM systems. I've seen a couple of
> > times Lenovo BIOS has the PCIe root port hotplug enabled and that's against
> > what the Barlow Ridge BIOS configuration checklist says. Please check if
> > there is newer BIOS (Lenovo has been fixing these) and of not report it to
> > Lenovo.
> 
> Thanks, and sorry for the slow reply. You were right. Every oops I
> captured was on BIOS N4FET30W (1.11), where pciehp was bound to the
> Barlow Ridge root port (0000:80:1b.4, "pciehp: Slot(25)"). The machine
> now runs N4FET52W (1.33), and that root port no longer gets the hotplug
> service: only PME, AER and bandwidth control are bound to it. So the
> slow-link "replacement" that started all of this cannot happen there
> anymore.
> 
> Please drop this patch.
> 
> For 1/2: the trigger on this machine is gone with the new BIOS, but the
> ordering problem is in pciehp itself. A device replacement detected in
> pciehp_resume_noirq() still starts the removal from the IRQ thread in
> the middle of the noirq phase, unserialized against ->resume_noirq() of
> the drivers below the port (on today's mainline, fa4ad798f6f6,
> pciehp_core.c:310 calls pciehp_request(), and pciehp_ctrl.c:145 wakes
> the IRQ thread directly unless pciehp_poll_mode is set). Bjorn, Lukas:
> if that is not worth changing without a reproducer on correctly
> configured hardware, I will drop 1/2 as well.

It sounds like there may still be an ordering issue in pciehp, but I
would want a Reviewed-by from Lukas before applying patch 1/2 ("PCI:
pciehp: Defer device replacement handling until ->resume()")
