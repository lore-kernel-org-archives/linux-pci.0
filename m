Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692084;
	b=U6uNfWtZ6uWB3tP5ZPULRIUIs+MALmE9xpF5rX+/eo0hrr853KgZOECiULo/adWVWd+5
	 7ayCXdVgQ3PBCdY/UquvZqYPidU+KQyrGYXcOzqxwPI9Lrhx/9eB/nDgREPkSLWxNUVSb
	 7t+HkixRNWWsgPEcfIGSk8+scfTdjhtweMiIeUC7eqqY7zqTdjG5yZrjvlPdM6Oelbm8c
	 m6OSe2QzL500tWFhkPapwmD7f/lhv4I5vbWhx0PowWg/akmweewOyVeJDpqegdVGe4xMM
	 E98aL1FOFmhom9zJmiZU9jz/7Vgha6wgVut3JCTAkYjw0wWGeJHIBi0yKNkk2wlkrQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692084;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3UuAdt7dSVCdcMjg2v0KRdp+uX84J2DmHB+3MfIgCio=;
	b=VmLc+QW3BGDWa/8a3y7T9Ghy6Zbiq2u4ANb5cygZtzqUmraBuTWipin/MSS7RV6XI6ck
	 N+Al4AtN5QY31StOz+Cm2P1u399SLkxgeGX3ineelDV8qXZ49gb9reAGqXQZQE84aHY4u
	 8bUMadaA9TVGHyhQju1KSX4X2lk8cT5GIShs8DIGq8ln/p8nJofP6oKbW8XLEzP795nrR
	 HiyBMqbjY6VoOi1BWUqujy1Nk4twaQ4G0vCMkYnUOQjCDXAUauyuEpeqeeF1BxUU6+/OM
	 4PHyQXl+8yIUuu6r2Jcf9xUnwsahbh/tsc+Ejn+9T/sT2FRvrkvP5jqD6jVjVtGlQmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcMpkfYU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45118606A337;
	Thu, 26 Nov 2026 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcMpkfYU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721DE1F000CF;
	Thu, 26 Nov 2026 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692083;
	bh=3UuAdt7dSVCdcMjg2v0KRdp+uX84J2DmHB+3MfIgCio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fcMpkfYUPPxSdHrXBEDXH5r0pdjxRpjy93Zt4Kx20zZYirYAJUjl5pIDbOUxZecy9
	 Z6lQHKg19QGO7V9fxFM3spvdLuYK6N3NLsSac6BlvrOBeV3KF7LnhY/sgcq8gYEInD
	 yczJOoLOYSUrP88rqweUx8QDgqven4oPCZzNgQ3PvP5hHsn2/TNVrKqvbm8dQl6HjR
	 1PG6SEttsPiCPgJdmoZU4DHzPCx7skKD2aFyv42T6DcZXpQhgI7rRUU6Nge0FvvTDb
	 7veKQ6wKzE15RxQQ57HkIOQK+YOe0lgTrA5j0ufjwTuyRf/KkPx77g693TixMxVwx2
	 89vRCFbq+I60Q==
Date: Thu, 26 Nov 2026 13:21:10 +0200
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
Message-ID: <awgWJok0E3ASR7Q3@kernel.org>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com>
 <awKlfqlQYhphXCvf@kernel.org>
 <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com>
 <awVjqLFrXY_PCm7X@kernel.org>
 <DN3L5XQDSVO9.1NJFYQJTS16ID@google.com>
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
In-Reply-To: <DN3L5XQDSVO9.1NJFYQJTS16ID@google.com>

On Tue, Nov 24, 2026 at 08:36:22AM -0800, David Matlack wrote:
> On Tue Nov 24, 2026 at 2:15 AM PST, Mike Rapoport wrote:
> > On Mon, Nov 23, 2026 at 11:07:04AM -0800, David Matlack wrote:
> >> On Sun Nov 22, 2026 at 12:19 AM PST, Mike Rapoport wrote:
> >> 
> >> Hopefully I did this all correctly... This is my first time sending
> >> in-reply-to fixup! patches.
> >
> > This is my first time merging !fixup patches and it seems b4 managed it
> > well :)
> >
> > Please check I didn't miss anything:
> >
> > https://git.kernel.org/liveupdate/linux/l/lu-pci-preservation
> 
> Thanks Mike!
> 
> I checked the updated lu-pci-preservation branch and the code is
> identical to the v12 I had prepared locally.
> 
> One commit message nit: "Freeze preservation status during shutdown"
> ended up with two Link: trailers, the original v11 patch and the amend!
> patch:
> 
>   Link: https://patch.msgid.link/20261118223704.3286085-12-dmatlack@google.com
>   Link: https://patch.msgid.link/20261123190045.2166865-4-dmatlack@google.com

I dropped the second link. It's the same thread, so I think it's fine.
 
> whereas "Adopt ACS controls in incoming preserved devices" only has the
> original Link: (not the amend! Link).
> 
> Not sure which is correct.

-- 
Sincerely yours,
Mike.
