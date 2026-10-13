Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D851DDF8
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910211; cv=none; b=dbKFb5zUn1ljFDriXN92PX2rhnlyKitZte1aFsNWPbowm6JooV+KzAaoqCQ0RVzbXDB7qRmg4jw49Swg5sboGw3+agqQJLHGkJP9H9qjranfv9ZLtHpohDPWMSKt2SdURQgfD1YoraOLuQmKGxMa3KLMsrT03PWQwpBg/wZltxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910211; c=relaxed/simple;
	bh=7nzPH+spIl+VFhBQ0La9/DW0fBZ1+V8PlC/sPvoM04Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBhcFLDqJtfyUpMRK2K7nQ992wMyP2LZ57d0eb/oCpanaZcSwzCQVTbNRGeMdhTX7wt1gYn0uH05xmI1evQJghrtGTexlVESz+x+7LGTaH5Er6vE8Yav0qGDeVgtds6lwY/DrOusYGC88G5CqpG5T40A+PSKj9hDZgiMok5LJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Knt4PSGd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Knt4PSGd"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab8309dcbaso2329536a91.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791910209; x=1792515009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqaPQWFTpGy6Tato4Cnm3u7MBWIxvKK7hZ5Hxsyu9Wg=;
        b=Knt4PSGdDAqK0n3Qiec0m/sv+74bEuSHrGx3aKwcy3uAdb/AEWqZvbXibK8p0XxUFL
         zhXAlNNlQ1cWi0nvdWvQ96NZUqvHLNZfaulKHRUURCSUvhyM4abCedqckZX/pHEqjUtd
         KznWFi0GSehJwoYoMXFFPJ1jqKjcSUUrNiJPLz8T2mQVEhq2QunGB/T39J6rTYEeHrQt
         brCgCzDWCPFB+avcGG5KTstO+6Q0ezOn3ImVEB+5YsNNuNXToEpbtzHA+Zi6ltzjuqwS
         2lZ3mO0DVfEOoV+s3Oza8/wccWMziIC4gFpUdRbhtpOfzi5iEsT+4LU4VBPTdaTxMDYu
         Q6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910209; x=1792515009;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqaPQWFTpGy6Tato4Cnm3u7MBWIxvKK7hZ5Hxsyu9Wg=;
        b=lGCK0zxE2vhZr0qk99jiz0lWDNA4Cu1YIOjZaSoA6p8sVzHJ4G1ocR9u6UYr/hZxS1
         u+A1IFrg2fxRhRFYMNiZpujSHg0pjAckINI+pNqFb2LG6JM37FTvbUdXmu3byk37MjRB
         6IBlL6e9fE7lB88WYTqIa1abRTj7vYM7Tes8ypuaJy7VDNyfKDeLzvpehaMAX4+0d5PL
         cB7ICH1h32EYj41oBUSHOIZRscLbimLmv6IusS6R5Nqem1Brjz15dZoyzFGmE53dbiJL
         hBYH1myy3M+g4nrCP+HDB7lCA4TvDmiqd3FD3fwA0Hn/0vecnnSKIv9L1Rf2kthyjsV4
         qO0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxqUfX6eLOxyYwykUxgX8LY+QON9JYOgLethCbrs+wLinbnoER8Ufpk0Hf9XeOcK5vUPnb0Z/evVPE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnN1af+Q/7SHoash3d8J7Dflan6KqvCoVkEH2eM1WlwFpMvvyf
	V7E4gzteAEz5VwkTaxtOQzzZFgstzQTCtwc4Vlb1WHqFKN289i2xegTnPfKoCVUrCA==
X-Gm-Gg: AYBFou0o6aNDektt76N7IvMWiOvFnWt3xjOShdJXRWCzpBoRhK+FhQk8zs0QKivj/jm
	vxYrBswuM3h+22x28Fl2y+7msMoMqAy8jYESPyhYokpxDUzvg8E4THrpgm10NAT2pubMgADoH17
	KyIj9VZAEvCs5kDhFI71kF0QqxKv2nYUsRgIbYnWf7RW3/2d71u3eW9+e694DUD95XGl/Deymeq
	fCXbW0CWakO8MvQq1fEqL6VY+5OWoq7aQHuCpjvfdKLGrK6K4KMp9ADb8zLgtLBERPA03dzeM20
	qC3lY3qUe1Rr9hTPK63/sWPH2WY/7Wr3Qr1NgdtOuEdBTxDSw0f+Gy9S7WDsoi2w5HpQMK22Wuq
	/PMv992wLrh0NXB5KcCnF4+w/wpnXLyVTtdufyUKEm6ve0HI1r9D4O8NKHvl+DjgG6Tu5LI/mpF
	sm2v7zikqQrdkk6D9Zo4ls6U9w6dtDWbvzGFWSDf/rh8ZvVVpTDA3ZuykbZXsRkWY/tfJQPms6E
	OTVthDoaca53XIaruFQ9dsNyeaWQzh6Dhg=
X-Received: by 2002:a17:90b:1dd1:b0:3a0:c85a:ee12 with SMTP id 98e67ed59e1d1-3ab3aceba09mr7658162a91.41.1791910208352;
        Tue, 13 Oct 2026 09:50:08 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f3db2f5sm410850a91.1.2026.10.13.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:50:07 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:50:03 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kexec@lists.infradead.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <as5hO15vdv3fnMeh@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-12-dmatlack@google.com>
 <sashiko-outbox-170132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-170132@kernel.org>

On 2026-10-13 04:39 PM, sashiko-bot@kernel.org wrote:
> [Severity: High]
> If a user task exits or closes the Live Update session fd during system shutdown,
> the LU core tears down the preservation session.
> 
> When dev->liveupdate.frozen is true, pci_liveupdate_unpreserve_device()
> returns -EINVAL and leaves dev->liveupdate.outgoing pointing to the FLB memory.
> 
> However, the LU core ignores this failure and unconditionally drops the FLB
> reference:
[...]
> Will this leave a dangling pointer in dev->liveupdate.outgoing?
> 
> Since pci_device_shutdown() relies on this pointer to skip disabling Bus Master,
> could this result in the old kernel leaving DMA enabled while the next kernel
> treats the device as unpreserved, creating a risk of memory corruption?

This can't happen during a Live Update kexec.

kernel_kexec() calls liveupdate_reboot() before device_shutdown().
liveupdate_reboot() calls luo_session_serialize(), which takes
luo_session_serialize_rwsem for write and, on success, never releases
it. luo_session_release() and the session ioctls all take that rwsem
for read, so once sessions are serialized, nothing can unpreserve a file
until the kexec. If serialization fails, kernel_kexec() bails out before
device_shutdown(), so no device is ever frozen.

So during a Live Update kexec, unpreserve cannot race with devices
being frozen, and the outgoing FLB cannot be freed out from under
pci_device_shutdown().

On a non-kexec reboot or poweroff, LUO is not serialized, so the
unpreserve can fail as described and leave a stale pointer in
dev->liveupdate.outgoing. But nothing dereferences it at that point.
The only visible effect is the "Cannot unpreserve device after it is
frozen!" warning, which seems appropriate for a session being torn down
in the middle of shutdown.

So I don't think any change is needed here.
