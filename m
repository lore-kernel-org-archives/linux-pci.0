Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0621382F39
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681005; cv=pass; b=DJaxk8V3rX52nihQyvZGh5am8wrQrAAwm1M2xxOCPAgBEEEMRDYqy9wB0xKNeNrQlg8oKXbXqTlQ3G825fWkpfvxHQZn2rjxLuq3sNfWpnyx8lgOlO/SPgaK6O+qV9qsUPcVHCTF09nCGOWtLmA0rpAaU3a40Y8LOWwgyzDc42w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681005; c=relaxed/simple;
	bh=dkI9QqpDtG36LgG+kw8ZEzl8s+Rk40Z2naIpV+PYS9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANuw72mxAw4vJAyb7s5Z/6BcneasgdusT9Ru+RsWDEBTlHLMKNBGr1u0Kk0D4YJqUbGicHAXj5lNDAPWnDZoyUX0qYSNCm8AOT+tYCo9KdCFPoFDm+nzpUjUl2hO5LG3qmPwbQ+UavwxGYx8lYhNniAU9GYM38/f4UnAiVn9I9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA8sNSIY; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA8sNSIY"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a140efd2d5so8761171e87.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 10:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681002; cv=none;
        d=google.com; s=arc-20240605;
        b=DLuN6eeTLGnnxIbj+ulz639lcyB3RbXff/pmlUKWw69jZN2kdt8fFcUmkJl1me7Z0p
         FeRjphO/ZSioHva9PsTcButhHW6LH8whszX1AsfsBLrPKev5yppD7QLAzpb4EOzOsF5l
         5j+ZHzTRW7beoiNr5eLnQhByM/C5ulcb2UJf3Vctts+39L7cgqcYqjimjfwPL5VEUwoI
         jGP0uCz2cOu7HBB9+6wERPzGav16NWjYeO7OWpVeGXxVZmu/MOMogdEnLmxtPt0eLIvj
         5/+xH1/2eS4OoVeMzITbHyul2nbt131YSnczynZtvoc0yG+v7g+yPNomgs1tHFRSgJ5Q
         V4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        fh=zuofATQHDUmG8WLLcaEOyFWMt8BYO9ZRI3pHqrnnMBg=;
        b=W/ULSDdEqfv1M7wAn1C/ZYE3qMuMnvDof7KLdZhk7JGVkmjDMA4VOXLLI8KkZiwEMA
         nZadkc5yP0R+TikOXLF2tQ6xmV2yNzjxJdc3MdSxAiT6GoWP2+K4IJbxKopfTOx/BALz
         +TA0saU9IF/zQRiB5/FdNYv4zhoBroPloGZeBLJE0ReO+nre1vSnZ2ilD144CkXFblv6
         ztV6/nEA3eazkBgfnUCNEWTVVXMK5g9gQ/LGN/fCjpw4A/8ZkKawQZOx4OpZMVe4+Kxx
         PopT0TULVlQubt1AedUtamy8GPhCDqVnx5imw9Ec/HeiOWCXIEntSXTKzVI1B+rDXIbG
         BXIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773681002; x=1774285802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        b=vA8sNSIYf/v4LksXXda0XuPKnMxUj1Ibw/V/HMiYc0uWmvIPLbjMjZutFH3c/xTpU1
         RAACgDVXP6gVNYR/uFS9P972GPZRJDMuLumL9oCN8g6TCQ5IqQKJmvZeOtsCc7GMlM2S
         Aa/WFaphNihK40YrMJShq2dVVayP7l5bbY8YUPt0AF6KmANG+U8Csv3zxhf2DSR7QsHq
         jHtRDTb4g0voHjGWEzKpDs9CSbsAig34r9K4wIz0rzOcvVmAPXinmzrWqi9oZxytnRsY
         dPAMooGHWuj0Ty2OwKmypVsAHPji3dnmov2T0RsZkDz/9yTkcc/BUuauM0YpgKZMaP+u
         sGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681002; x=1774285802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        b=Oc6c4eAeFOHz1BvLzAtNu3fEV+5OvsVlMrMQbPMSkQ+mYIf5fwOhHR1InXN2By1O9e
         0ydjr1sZrn6M3ypYLhzrOfhQ7aMqSMQX7l9bnY9zlQDhET4pSqZRk46FI5Ikoh0aGLuN
         awCaOh3dWo3DOM/kHObTxmEOo20oSM7FStqC4QHpy2pIpz287QGxNch7BkBxESZvc8CU
         6YwmHJte+WnVJSPIBAimzAcYsYQBeM8KTP1d0A5cIegLAQyJ1UytNCHuBJhKxu5+7H5B
         NYakrj5lmadt9l5+x4ev4gfKBVY3Q3+iQi1XPsCS3q4HAQLJOMskivRQTBs94s/nfzGO
         xkgA==
X-Forwarded-Encrypted: i=1; AJvYcCXMv8bG2kfqwMACQQtLUy4MGKHFM4rrT+RQnztusL3jO9pJjxnzEn91ipTacO1AFCUbOZTNKd/j6z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaakvqulPfZyoJ3b53qYeV8lLLhm030MiBQp9n6J4h1RWYWrO6
	GDCzO+S59fNfdHl+Fq5HtIyAv+/yAGkzUD9KF3CAG3ztHNlei8ESTVgrXKrviFiM5hmbO3dgdaj
	1DC3ffB9oeMzMSHhNgzHRR5bYoB8uYJ0cD2SB5N2q
X-Gm-Gg: ATEYQzwOsUyf/VkboigHP/eHxkU9oGnnAw1ZWx+5OmZddrRFXSOqTnHQd3ii8OV53pZ
	OLetbhKYDfdSusAoVVWSmEE+22YhDma/6RApV2ZnZqwQPEyf5NJ9idxWJizpiJhxUbumucgPqY6
	Zrub8vv8MPK7L9mToxkKRJQQCy0oM0ye1a3yFq1/e+3JrVj6s3WPjYqDJIdvX4ZZ/XnRRFJ7C9q
	rqxTs011v1elL1yqRnaADqEbDLt4VsfB0hELS6/ivQGD4F6Xnarb/yXguPAPYD3QrLW71G3Hy49
	NOgFL/ep/O2wRIoKCcQ=
X-Received: by 2002:a05:6512:145c:20b0:5a1:3207:694c with SMTP id
 2adb3069b0e04-5a162b0c23emr3396226e87.29.1773681001667; Mon, 16 Mar 2026
 10:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-17-dmatlack@google.com>
 <20260314073250.GE4177610.vipinsh@google.com>
In-Reply-To: <20260314073250.GE4177610.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:09:31 -0700
X-Gm-Features: AaiRm539MAtTSlMtJ9cZiQMw7S77YkLj3Qx3YTaEKJUIvtilcVTIw0VDB1yQ5S8
Message-ID: <CALzav=fWmv_+BACzTLq2Nj2aUux575EnbLRwJTevH4aYZTXycw@mail.gmail.com>
Subject: Re: [PATCH v2 16/22] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:05=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:25:03PM +0000, David Matlack wrote:
> > +
> > +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
> > +{
> > +     int ret;
> > +
> > +     ret =3D luo_session_preserve_fd(self->session_fd, self->device->f=
d, 0);
> > +
> > +     /* Preservation should only be supported for VFIO cdev files. */
> > +     ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
> > +}
> > +
> > +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
> > +{
> > +     int ret;
> > +
> > +     if (self->iommu->iommufd)
> > +             return;
>
> for iommufd variant, should we mark test as skipped instead of showing
> it as passed?

Will do.

> > +int main(int argc, char *argv[])
> > +{
> > +     int fd;
> > +
> > +     fd =3D luo_open_device();
> > +     if (fd < 0) {
> > +             printf("open(%s) failed: %s, skipping\n", LUO_DEVICE, str=
error(errno));
> > +             return KSFT_SKIP;
>
> Both can be combined using ksft_exit_skip()

Will do.

Thanks!
