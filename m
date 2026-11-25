Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596559;
	b=2KtqMyO4Iourzk2hYttn5GFPPoCKv6EmG04Z/i/GAKvjqgxT3goXnSgX9KnNTD5uRkFO
	 My//Vf/oqyd4Wls/f5wpNa3BFWhlwAfhtmHwvVSn1qmiCAqLPxeXRjPxvwAgO57LTwaok
	 N7ubEMqW+A4mpoCkGQ43IJD1U03rQ80p4MqKITTSbhb4+1/bHX7V3GZY+T09Er25zd8nL
	 NAchWsVSp/pTkcB0G30HHqZFZTWe+i+5yd5gOvUV7WNvKsSlKllMesBUueYK1udpOYBcM
	 2RfOIEFgO7tAS+gljD/+l3C/paHWuCgmlWfrTuSx0EboVo4Mo9EpjCr38YycBfv3djw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596559;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TlND/jXIyTOutFCDB5DXoV3ddiKsYWv3HLDMVOOuvUk=;
	b=LQE0vBSdlPqY7FItSS5Dr/dXeU+XAOTqmx3rdyr7nSCtCBSzyk+CVGhkxIp30kXbnVin
	 XrupdkSZSCnG5UsKMEq9dDGfzH8XfCSzJGj395bQT9RH8KAQVeB2Plennd22/fmN5wamK
	 fgztazqQ+NMWDzbq7DqS5QDQ9kEYjq1Cjb7y1ilXLolDSENXAZqF4vHKA4JJGOpbjR/Ga
	 C39LFiRAWs1dO7X7u/FZbRC2jQtYwlvwJ0GcKUjrPjA0MW8gN8tmdVZJukSr2ZhqY358L
	 ydb0FZvg20BMPXJIb1mwNGictZEYP2s2E3o3yE3KOdfBvHKEYjuwDJhCqypagD1+ruQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbvI696z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0287606A68D;
	Wed, 25 Nov 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbvI696z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDEF1F00A00;
	Wed, 25 Nov 2026 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596559;
	bh=TlND/jXIyTOutFCDB5DXoV3ddiKsYWv3HLDMVOOuvUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CbvI696zR6OtVXAPCG7g/iPy03A2oTw21RBe6JaPhJHFPRXi+H17lOBRzJrgNARtn
	 r+fRoufm0OiktxQGgsxLm9zCVTMRoj9kPsTPBWqqSY5vGYQEAuqD+14yaCOmlKMYgF
	 j1qfbL6ZNKLE7MMyEMUkcV3l/4FT2ZkmMgDykuG0RcIRla9mWdpv0NQJXIM+9jb3cF
	 VJt8oZcFXReeREr1uqelf/3atuLgWEoBVmlLglOje+t6FyydCXpPAQKHBjUs9j0ERg
	 xnHTGpj/TffLtZ2xQ+zgZOe75RLjcDXEPhX2RuZKUdYZKO2pec6w3jDkKOOwtf+v8j
	 Gmrfe0Cs12QCA==
Date: Wed, 25 Nov 2026 10:49:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Chris Lu <chris.lu@mediatek.com>, Mans Rullgard <mans@mansr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cornelia Huck <cornelia.huck@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Dan Williams <djbw@kernel.org>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 02/33] Bluetooth: btusb: Fix MediaTek ISO claim locking
Message-ID: <20261125084905.GX14811@unreal>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
 <65749362-927a-492d-8bff-573c277fe456@suse.com>
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
In-Reply-To: <65749362-927a-492d-8bff-573c277fe456@suse.com>

On Tue, Nov 24, 2026 at 11:39:40AM +0100, Oliver Neukum wrote:
> 
> 
> On 24.11.26 10:43, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > MediaTek ISO claims are performed from HCI setup work outside USB probe.
> > Locking only the interface does not protect the claim against teardown
> > of the parent device. Unconditionally waiting for the parent lock can
> > deadlock with disconnect while it drains the setup work.
> Hi,
> 
> your patch raises a question. Can usb_claim_interface() ever be
> used safely outside probe() without this kind of locking?

No, it cannot. This is why need_parent_lock is set for every caller of
usb_driver_claim_interface() running from .probe().

> If the answer to that is negative, should the locking be integrated into
> usbcore?

Not in the current upstream code. Currently, only two callers of
usb_driver_claim_interface() do not run through .probe: MediaTek and usbfs.
usbfs already holds the lock, leaving only MediaTek, which does not.

Therefore, the caller should take the lock, and MediaTek is the only caller
that needs to be fixed.

Thanks

> 
> 	Regards
> 		Oliver
> 
