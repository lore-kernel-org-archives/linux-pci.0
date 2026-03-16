Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3143264F3
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677101; cv=none; b=FC7O9YUBhICNBFeDbvxstEknC08zENVIvTtk2eeqXR/iOklgZlK5SR4duso+yaDM64qp35W0GDvVqmeXljCN4rTNPQbou8ekTh3dCV3Y2EZ68KOiltpn2TkbjlisRb1uhVjlnZx9ZBGTRGgcT1j8zdIjbK8i5DTad5bS+XS1t5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677101; c=relaxed/simple;
	bh=pnPMIg6QAJhhfdXh1P/12ht0oe+xBK5/i0AcyCLYy1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfHHQxJV6TR5ROiapuwo9FXX938/G2tTvtN+rRzw1+ahAO74SRTDDlZnCq1DSo22zHKRy34jXDm+Fxr930CjZ5IWukKW7X9CoegKq326Xj9DCZmve0IfZcgIb44Hdnf/D7XKMclNJ5eTAYbxN65klNqAAuA55sQwB+KHs9Tag1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BmZHXHcG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmZHXHcG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b052ec7176so94085ad.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773677100; x=1774281900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9RU4Mq6bXwi7763tJq20duY+x4lhVoegGX5yfdZIpA=;
        b=BmZHXHcGJzYaI37c8BNWaiYCMivWtKyuq2oIQA+zrVNsgHcNRJeLBNiGc/b9XMmjox
         REcRfSnIa+BHCwdtM/J7AKMJhmD2nKUcYn4H1Hjv/73RMiOwzjh35UY+YZVPTS59/iSM
         1YPelz89za90uNuVPmnw8be1a4I2fB7rjQyjtuLZVxrHGvcCOmzm/0l1DbnaeiOQfqJR
         SMYfQuFr+0qDrFL/mVHVsdybWPG9Eb30Ty70c2J2BSKDgHATcleAFEjy+g+IVbxgIjeG
         3owJZuNbCyzutxl1wQ3Pu+flC0BLlyvCxBGQg0uf84ye4w1sr1EFdDKZcI1h1/aoyt1e
         FQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677100; x=1774281900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9RU4Mq6bXwi7763tJq20duY+x4lhVoegGX5yfdZIpA=;
        b=XidaIk5q80yCnG9HKCh7Rs0O6s2YBVqGMX9XySh8J/kHdDfUS1zL2IQL/WqTsm+E60
         8roQGy0DxyOSoG2ox9atrsdwiu+VfwtSQBQmBc8XNYxg3dBhJDfHDdHLoneNsLsQhiqj
         Ql4HXHxUjZ0Lrh3C9chTBF4mJdOl7c5SRVicvuoA/pXkOTCy+QZSWBBf9NGZujG+QmLS
         QbU564A3hPZU8WKr+GF9/ax6hyf4yN4zz1hofsmkEwr3aOI/EUrFn6UN3nhZZQMEt/3G
         rCSaxQopeOgOuqIqTEQrBjn8XTgl2xTlSO4tn+H4a3SpMJPBr5VdNNSWA/TBAXCjyqTr
         Xa6A==
X-Forwarded-Encrypted: i=1; AJvYcCVo5/4d5B5oUJOAs+qtMiv63FSSZ9IGPnTUmlipJ45poZ9Vi2RTgajCWr/hdXG0YKg3JNp8D882SXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrb5CiFgFRk0Wf0zL9z07wf7X7siHtu+EhuWWlDEo2m+LWbegz
	lifuCz676ioKL8WXslVVz6kzVDj8GSPiOIzqq3EQm0QYnatNnoObibWg2HylGFoZ0w==
X-Gm-Gg: ATEYQzyY5PWiWVo1g8NWiEcRbKnTr3TTubf1TPiyqX87K0EkHdMjz2M6gYN8SAHTY6a
	cfZbxkkrEkGHW4XvulQEeNp74nY+pmOz/0ga4ZpmuMwteJDCm30ByWiFXLH4I0SMeM4Mp8chfi1
	S/+D8ewmImJd6K7DjO3ac5XMwdRF8JYbFSHwyAs5ZaIbM2vUtw+Dw1duFzqD033a1L39c112nmB
	yTpm9BiR6ZcRGa+xc91ZoJDV8Bptafb/C8x6Z90KbUKKd0w45s3vfVXfq9ikn2gZWwkOLVfNWbS
	2lYhPnL4z1QFBIYRsDvfjuZ8Ut4FN2Yt62k6GGM4LZ83zg3LsZh3Osl2O5cLbXESU0jTdLFp+5n
	ezvS19FFqKAhz7UwrIM8gXB5OyJ9k7PVvl1VphwoIdIbCz/ZTrA4D5AHi9yd83W9FKAxc6eP1JM
	sQkruVF07VoZZRYiGLeuWM7AgkTKOozns7ro8GL7K8PordVYQpxIceiM+VWr8X
X-Received: by 2002:a17:902:ce0f:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2b04215e0c7mr4424785ad.20.1773677099288;
        Mon, 16 Mar 2026 09:04:59 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b048527a19sm71890555ad.7.2026.03.16.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:04:58 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:04:54 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 16/22] vfio: selftests: Add
 vfio_pci_liveupdate_uapi_test
Message-ID: <20260314073250.GE4177610.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-17-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-17-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:25:03PM +0000, David Matlack wrote:
> +
> +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
> +{
> +	int ret;
> +
> +	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
> +
> +	/* Preservation should only be supported for VFIO cdev files. */
> +	ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
> +}
> +
> +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
> +{
> +	int ret;
> +
> +	if (self->iommu->iommufd)
> +		return;

for iommufd variant, should we mark test as skipped instead of showing
it as passed?

> +int main(int argc, char *argv[])
> +{
> +	int fd;
> +
> +	fd = luo_open_device();
> +	if (fd < 0) {
> +		printf("open(%s) failed: %s, skipping\n", LUO_DEVICE, strerror(errno));
> +		return KSFT_SKIP;

Both can be combined using ksft_exit_skip()

