Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515317;
	b=iVslgoAZ76U4cMSbHbR3CvVm8v+4QFwA/NNn7TCIYuAsBROaZgJnECVyqnLuD9Xm5sIx
	 hBLyBKJwveGziuSVJKPpsa9XF4QxMP31p0g1DwjiUtsSDQM6i+Juc3yuybFuCXZQYDOuz
	 0VQJlMIuyqO42ekJYSS64b7ELr70zTSYLZmsAAOKmZeaWKph9E9aK8ZPKSaRnXUeQBhRB
	 yccZ7b0lJ3QD5w94Gei61/cV8UivGoY4ROHwwM4uo560MuIuQaG4eTjDKBbmyk4RI3i4z
	 Rn/voTfDf2ZRGB8afiQMxxLpFLd3eY/3zWHZgwW8HmJhSS+Q4Iopx3v+nohqNfI49mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515317;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hHECIuUR9HcEzeZJ8C7pKu2f5dLD2DBLgztjbd6Qj3I=;
	b=MhQsUWZN3XUk5Ee2XMS4k1XqvoEYJ195h4DAAADFyuZE2dtmVxegQuR8u/beN2b7B5pl
	 18akgjW9DR6ueaELbl4dNOzeeRvBVN/V/lvohTFONUUZq958zp3ZIBYtAna5NCeQn1WBl
	 t1OxevJogsfvDDg5S0AM+R/3Qdq2HmIr3eNtt06pqr31z5tuMSS7ORWil0G/rUYBVC6R4
	 hEjnEOgpXuRF5BmBh2cO/f1NecuuEnGkw8GWeT8GxYfOItWzbyWvrBWig8vA+atHKy/fe
	 1iTbARDxZkXadgSqzt24ZgrmWs2J0+Edp2wpnocbvC3y+iUy/nSYCEXi4BUTP5MVEZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPWKFZ5L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D93606A32D;
	Tue, 24 Nov 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPWKFZ5L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E031F000C0;
	Tue, 24 Nov 2026 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795515317;
	bh=hHECIuUR9HcEzeZJ8C7pKu2f5dLD2DBLgztjbd6Qj3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dPWKFZ5LG9YCMDzt2kiKA/v9gin8Z5x5M8m2NT7aGz3CCfIJbdV04+DqSdm8fUw/y
	 HcfWdjV/MgD4Q+SHwFPx6zJVZQvjtnQ44m9MwLz8lV8p5m2D43+hdZwctL1wLtvWuz
	 yODDoYeYLT6gtj4nJIDi6u7UIh1VTYeU0hn88qSrp126h1r9fY0p8eBz61Hj6TaKu9
	 i2SuPF0ywEaGPdevN74Hb2UVMyQLGn4R0MwB4yjw8L/t7p09RHj3wuhsEvDAvaP+MA
	 shL/P5t2LSFLsKwtd4zWfCarVE5KK448QJf/Vzn/+6WbPNQ1cwJX4LJqYk5tPHWz5v
	 aWTdOo//a6l6w==
Date: Tue, 24 Nov 2026 12:15:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <awVjqLFrXY_PCm7X@kernel.org>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com>
 <awKlfqlQYhphXCvf@kernel.org>
 <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com>
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
In-Reply-To: <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com>

On Mon, Nov 23, 2026 at 11:07:04AM -0800, David Matlack wrote:
> On Sun Nov 22, 2026 at 12:19 AM PST, Mike Rapoport wrote:
> 
> Hopefully I did this all correctly... This is my first time sending
> in-reply-to fixup! patches.

This is my first time merging !fixup patches and it seems b4 managed it
well :)

Please check I didn't miss anything:

https://git.kernel.org/liveupdate/linux/l/lu-pci-preservation

-- 
Sincerely yours,
Mike.
