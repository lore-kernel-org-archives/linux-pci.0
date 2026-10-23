Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771157;
	b=OQDvdYhpeajf6MQ9guzrxiAyPwwkxf/X/4o6YmI3TzMdiZBOK5S5UQzG1PY7J242l+As
	 9sD9C6s3DJ24eEIKm8q7k8ddjA7GqDhbBY53onITWWP+pX3uHgjn8/FoidukhGsMZl9ex
	 MaX80mYT9TOOX4OHpAxyEnwnJ1vbRvDxE/tCZgNCUbHuyirXCZRQEMSSPT7gjL708Jzz5
	 io8uoHgOMHufuIk4TqfmAcjaMtKwnXyYWVTW8f0KmrGMwuxNqWqwsU2+BBrTP0s2YEQlj
	 dCibSnNTp3hviduAAIXrpKS4DQB7xQme4PVll3vGzx2oYYkFHHRGX/QQ/v1NMiYzejg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
	b=kuTDqNnx0fMDrBc8sjPZxFiufm/btR2TuCLGKmUt3Dq9G9mqUfCiVjKrnzplZBetnKH8
	 76ECQSgtk5jQxK0+dMcvzN7+aGbHgUlsZ8EBWGgXtBQtoKxOtuREOZ08S6OraKp2iLpD+
	 GHQfe9HVfalawc1H8Df2ezEyWxLzA24nIhOLf5CigiZK/MT83yBoIK0ovcFnntzq2P+Ux
	 DlhMtX0EZUublqur9xoWet+j09XbDMwsPaHchYv3fhYboZt6Z2b8kjJOUsU0Bf7+dKLwj
	 iOIAeo2PKE1lMf2qKw8eapOL/M2LUYQoz9sqZe5mJ5ZmvXigmwILGPxCCdKILDrv03g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pOV9sna9;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC5606A31A
	for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 15:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AAC5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pOV9sna9
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53644b28706so13933751cf.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792771155; x=1793375955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
        b=pOV9sna9TZaCqywtdDI8h+mSGdu3kY7TvcG6DQSaz/wzZ4RWxvzzkBqqhU+wauIVz0
         y7gqDg4Pv98+G/EoG0dUf5Bpk4Cl0e0UZ7LUISdotu9Tsw4EOlJNa9g21e1C+Zf9KMZH
         gYHQI9+v1MeGOmU6kjTdceiCLbZqOiGD/vZZ2gPbf7Lfpg+R46vh7tpjBVmQ5GGunmYC
         VtuXQ6ZEps4zStuYQLp7cEl/vePQpZ5aYQvoiujxoHTHp/fCRUKvmNk27XK19PLiHYCI
         JYluupC4j0EMlwXjgXHC4TBCzVFNeQ1eRj7qeCWp0ln6/w6oJwD1gZkKqq5ddT+khVyu
         ejmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771155; x=1793375955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
        b=EKWjxt7A8lJmGsIdtqG7rqDrghNDdqpyLVCcRogdOo5SN4R6yKcP0UnlGFlg+06qI0
         7RXOoG794GAX6EHGnYPxyXY3wkSxMAgb0IcAL9VSpkcJDQJw7pF7XvgzKtRUAYQ7faAd
         0GFGsEhJxTsNicPLmHl0Xirdcq7XP+LFXaRrW5mFoJ4e10ffkDIcdGUk2dwyqmsiWnjR
         DFzdMcB19t+TCFe+d6JeBenmMFlh7D4FIWheWBDXgqLc5FsL7iROBbnUu9CtwZkb1DB1
         g5V/Yp5zJrv7ieCRlidpxEdE2z+LD05iXHvRB/J1H7a3nFdzOH9P0nsvFtajgU6RIPgJ
         WHBg==
X-Forwarded-Encrypted: i=1; AKwUvBxbCo8o/telC/iD+JWh0vUY1HQdqmvmi7FbREzziMQzxwAahbf67TvHEe6vpsQIxQTdwkZpIMyeB9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYITQhhtR0uRMlLC8izgonBQHDVoGcp9SQ3b6Y1kAcWWPPelJlrg
	ysqv7UjeQakvu6NMVyTAZiFMRJ1bpS6dDvHCexV0sOKM4Ta+y7OVoZjFb5rqE4UDNTk=
X-Gm-Gg: AYBFou0/QD6qu4IXfkvuV8Y07jyxZB9L0w2VUg7kBxcFK5QyWgixputVN9rLdCcXdpH
	tuAHrZGWRE+EYi/PeU9pJ8HivBtRpanSi404CSIhE3msN6GE/Xo/jPJN5csu2uW7pzsGT0QcSkL
	r9nc5+qA8nIUTYee60ePvv8Sd/oLirQqWBSU+38myE2Ihpn/jBi6pdImyP1Q9NuFK0rJAWWGpce
	PWXuUhbXGabGvQOoidGJPN2AViLhxl605dIfNaWgBOydbIAgpVBuaybtOlXUn7hW0Hi0lhew1IA
	97bibJOonQeZgh+V8RE5fYsbyp4ORzC+9eS0L8j91dLcWqfj/wPScxp0f9Vd8ob+nN93PRY5GPW
	kgtc7Li6LWCc+dmGD3/gmPzUHJM1sAa8Xwgy4togQuOT1ntB4khxv2kjuQAigd9WJ5yEXEC+sHQ
	VTUbG1fbnzvYwMVE3+GDY3REkRxx/QamGlDZ0wfBcrTkzMi4u8VxXXs5ZwBFTViT0+JDKFsS6Sn
	/mgnj3UDFGFVrHQ3PPXJIRjkbEL43apyrmNaqvB9aISSXfnl2iHxS5sUa7ozhPhbi/L5eQTmQ5k
	wjbVLBp9uL9k3H8J5Q37VTY2Wr/SZ2zsqCOf4g==
X-Received: by 2002:a05:622a:a0e:b0:535:859c:b6ff with SMTP id d75a77b69052e-536c24e2452mr39136051cf.20.1792771155235;
        Fri, 23 Oct 2026 08:59:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53836c78f67sm656181cf.27.2026.10.23.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKHfm-0000000Go19-0EMi;
	Fri, 23 Oct 2026 12:59:14 -0300
Date: Fri, 23 Oct 2026 12:59:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023155914.GK3977851@ziepe.ca>
References: <20261007063227.GC7822@unreal>
 <20261007204045.GA783967@bhelgaas>
 <20261009174301.GC11438@unreal>
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
In-Reply-To: <20261009174301.GC11438@unreal>

On Fri, Oct 09, 2026 at 08:43:01PM +0300, Leon Romanovsky wrote:
> On Wed, Oct 07, 2026 at 03:40:45PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 07, 2026 at 09:32:27AM +0300, Leon Romanovsky wrote:
> > > On Tue, Oct 06, 2026 at 03:49:47PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Oct 01, 2026 at 02:55:10PM +0300, Leon Romanovsky wrote:
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> > > > > interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> > > > > direction can unnecessarily force P2PDMA through the host bridge.
> > > > 
> > > > Does "the reverse TLP direction" refer to Completions?
> > > 
> > > In general, the P2P code treats TLPs flowing from device A to device B the
> > > same as TLPs flowing from device B to device A.
> > > 
> > > However, in the context of this commit message, yes: completions flow in the
> > > opposite direction from the device's perspective.
> > 
> > And I guess asymmetric fabrics must mean fabrics where Request
> > Redirect and Completion Redirect are not set the same way?
> 
> Yes, in some of our systems, deviceA to deviceB is going through
> different route than deviceB to deviceA.

It is a little more subtle, I think practical systems try very hard to
avoid that since many host bridges do not like seeing only half of an
exchange.

What we end up with is Relaxed Ordering and Strict Ordering take
different flows in the fabric.

> > But I asked about ordering because it sounds like this patch expects
> > to encounter asymmetric fabrics where Request Redirect and Completion
> > Redirect may not be set the same way, and the spec implies that
> > asymmetry may result in ordering violations.
> 
> My guess is that the hardware and system architects have ensured this
> doesn't happen. At least, I haven't received any complaints about this
> series during internal testing.

Yes, the ACS combination is selected to avoid ordering issues

Jason
