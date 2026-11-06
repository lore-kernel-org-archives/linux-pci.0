Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984047;
	b=MSBzWfdSTqiHkkbA788nauMrLQ7DW3Dh+qKHNu+nOCskw9rW7QaPRgRh59FviCU8c0Ef
	 QvIUb5qi6Vf8Zj/SsIZZ2uIt7A/Yyaqnx105jTvz7Wuij1x58/UClSJXUjIOD9mZaEJ6G
	 rr6rwrf/9K16rpIS/DHYdFn2RbTslgkb/Jpg/pTe2DUR+WTr2Jtx7hvX/VGkJCMpqfhOy
	 f/VdXe/SFmoJh4fFYOVUidw76GsAUERAo/WebNrBz5VXbHYxo8WPuQRDp6EACOA6RaHpR
	 CMRHCHV4o6u8Ky6zVF5WzaHREsR3CugH/dWd9MpOFoR34DvTfSKiz7toJrs1ToyVU1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984047;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nXkPku4ECf8+FOGTi2fh40tjvx3x65bjc12ogntMkA4=;
	b=Egl5YKmLKkiA8Esn9ryrEu97gIxQwfgb5cg4qAbajP91x0mcJexr+DgxSi4goxucqD6/
	 vdEmPleNNgGgl+GDhp25cyaZfpSn7az+zABHrVXTXxSeP/UEwQl1vbebAhQluHASskes1
	 GNI0hl54Fn9mqehNb40HbLScnQF/tyE+/j/d8RKJ1Gp7j/mrsy0kuFKxV/MnaDjzh7ZsD
	 m5MFEWx5RU/+57LfXAWBgB6fJ5T4r8826JVpPn8NqxaJyMlwNIPLFASkHMltfvrqEYOLs
	 5y7JZIBMi8Ugkaa6BFSpY9qc1SxR8O/ULLXgYi+GOZViu+GKXTeQly+FxfGs9GKvZXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1119sdt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FAA606A329;
	Fri,  6 Nov 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1119sdt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091041F0089F;
	Fri,  6 Nov 2026 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984047;
	bh=nXkPku4ECf8+FOGTi2fh40tjvx3x65bjc12ogntMkA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=i1119sdtyhZsM8PknNa5avXoFmwzuiIke35BTEuBCbNCWkS1ohvh7y+6wQBsbEoEZ
	 eQN9eAW3mlCLhMojmvKcjCddRof0kSNMlSGm0Nxzci1Wz1Evx5ClpIWyVGUnTgxZAy
	 +RSLh79efseypAACmsCIdx3vtldAar2qEpK0SL2kAmGE3DoZM26Dg4q+wniBl2mlEl
	 U47AsA8uBcLZZXF6M060ruX673Yl4gxPbYsXSophDui+G3AlB/dInW2YmwLlO1rnAu
	 9DhP0Jo9QGK10F23c77M9ZwltzFkGUnsvcnC4rTSQz74vN0pSFcjjlTUzxiLdd8CLt
	 k4vobAlpOj4xw==
Date: Fri, 6 Nov 2026 10:54:06 -0600
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
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 04/13] PCI: liveupdate: Document driver binding
 responsibilities
Message-ID: <20261106165406.GA1632826@bhelgaas>
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
In-Reply-To: <20261013162529.1928093-5-dmatlack@google.com>

On Tue, Oct 13, 2026 at 04:25:20PM +0000, David Matlack wrote:
> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/liveupdate.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a1d9b2b1f9e3..d6b659b346bb 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -123,6 +123,20 @@
>   *
>   *  * The device cannot be a Virtual Function (VF).
>   *  * The device cannot be behind a PCI-to-PCI bridge.
> + *
> + * Driver Binding
> + * ==============
> + *
> + * In the outgoing kernel, the driver must ensure that it does not release a
> + * device between pci_liveupdate_preserve() and pci_liveupdate_unpreserve().
> + *
> + * In the incoming kernel, the driver must ensure that it does not release a
> + * preserved device between probe() and pci_liveupdate_finish().
> + *
> + * It is the user's responsibility to ensure that incoming preserved devices are
> + * bound to the correct driver. The PCI core does not protect against a device
> + * getting preserved by driver A in the outgoing kernel and then getting bound
> + * to driver B in the incoming kernel.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 
