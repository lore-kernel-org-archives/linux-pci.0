Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66882366042;
	Fri, 22 May 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472747; cv=none; b=PjtOsh7mirvDLZjCq3n9XYkrvOKvO6YM0c2jqhUBHOIHgNJj08gpBV205KLLoECP/OX43RptPSTybqBaehjIhje5An2ui0ujWpzb9Dis4fscg7quqMxmScM9eNEMvXa+hSuNyU/aj857mfmEPu2lTZq1D3MjCqzFDICoa1ZFchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472747; c=relaxed/simple;
	bh=8e922+jS//8NGIWTqfOW6k7zG1zpaE4rZo0LrZTDT+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YTuAcztSZw2kGyvqMv9cl170SP+E+6KUDIXnnDmdD4hmOZ+YlWvOW6WXKv2BNgR7fmQ0+See27pDKZXjTEoC4BxSPDioklwtPyn3CjJECvcRBy/sGhmvJOtIRUUxoqVTNfVfG2kCQQCxjG5N2FNwT695rQOfbLEkqZ8pKML+gio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/lF87yY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/lF87yY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 23DC41F000E9;
	Fri, 22 May 2026 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472746;
	bh=QvhytzGMgy3nE/I3M4lZRHo1Fz4WHKJA8K2mHNM+zQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=R/lF87yYK3T8ZgihOcJLjT1tJ2iqucYpoTXz+lE+iNM8GsdPFgTHohAXTIRWiXCaq
	 Z3sLJcXDGLxdXpbjd5vXsU6R9vl67LHiffd1HrCgb9F7RXCuMOOfdz7pnSMbp79xKx
	 bqeV2FB/iwmC+djHEZ5mqJS5Do9oSrdFTfzKqDljYArEUikYmdVLSGNtDVRe2CbZXe
	 nSlHxZCLg/t15FV7B3ebQdjPPEJOXYtquDgAXX27hU8eVFNYP8lGHAlA4FwFKLJOmb
	 9sPWoEQ7WIovdqVHFNJR3cl90/fD+OjTmJ5s3ncJReREDo+cltiTIVjISJ3mzjWVrW
	 j+eMJNK+bTxAw==
Date: Fri, 22 May 2026 12:59:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
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
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v5 05/11] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <20260522175905.GA232400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512184846.119396-6-dmatlack@google.com>

On Tue, May 12, 2026 at 06:48:40PM +0000, David Matlack wrote:
> ...

> + * The PCI core guarantees that preserved devices can be identified by the same
> + * bus, device, and function numbers for as long as they are preserved
> + * (including across kexec). To accomplish this, the PCI core always inherits
> + * the secondary and subordinate bus numbers assigned to bridges during scanning
> + * if any device is preserved. This is true even on architectures that always
> + * assign new bus numbers during scanning. The kernel assumes the previous
> + * kernel established a sane bus topology across kexec.
> + *
> + * If a misconfigured or unconfigured bridge is encountered during enumeration
> + * while there are preserved devices, itss secondary and subordinate bus numbers
> + * will be cleared and devices below it will not be enumerated.

s/itss/its/

> + * To keep things simple, inherit the secondary and subordinate bus numbers on
> + * _all_ bridges if _any_ PCI devices are preserved (i.e.  even bridges without
> + * any downstream endpoints that were preserved).  This avoids accidentally
> + * assigning a bridge a new window that overlaps with a preserved device that is
> + * downstream of a different bridge.

s/i.e.  even/i.e. even/ (remove extra space)
