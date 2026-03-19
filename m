Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D323E9F67;
	Thu, 19 Mar 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937727; cv=none; b=ogAoXqhBpH9xATpvHNjNYgW2IyFHyRF2fPKS+B6i/EGvNddEwSda/TEG2CY3t0EO2FOW3BlC6H9FFOeoY2TMBydzVwiehbqyvYaklMvCnFDWFgKHyMr97hbhfDU4fcQPAFsaC6jTzA4AsBk43JIDEEz68nKowyQA1wgx+4zJBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937727; c=relaxed/simple;
	bh=bjOJIOPM/2+acGORPk2A/p5g0k69GeX/tAxVXYIMaxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/FUIj3LbaN/MuWBGh4U7LsgTmCSycT3Ow0uHIbXuAKka1LIR5ZCwhSKDQiawVYXFoU92YZGMNa7gs4QP6xPKiXsZyCbsRxOaYEWrpcscfoR3kPK1b8sFccKR2yV2zSdHa847E3DXh4rN3l7i63ome5+S/Mv9I7xFFl9bB6Z5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qVsoVvGZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qVsoVvGZ"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BEFF20B710C;
	Thu, 19 Mar 2026 09:28:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BEFF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773937717;
	bh=H52Zybh5o34dbFpC/ZH35I3IR0TeF3CcjTZ7JtQFu2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qVsoVvGZBgiMTYzcaPymyws/zFtGLAsJuSf42v3omgVhgy4V/7SM/UFdDfZU97k+C
	 vY11I8eol4oictnvBu/vQMefqoMTn+2RHUiOztqmT14YgkRFwnc3yMPdzePNXNxnxC
	 Y01VMPNtIKCj5VPxAbfZbdq9ZRMZ8zsrYw0n9y2U=
Date: Thu, 19 Mar 2026 09:28:35 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf
 <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple
 <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Ankit
 Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li
 <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet
 <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian
 <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, =?utf-8?Q?Mich?=
 =?utf-8?Q?a=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport
 <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta
 <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260319092835.00004887@linux.microsoft.com>
In-Reply-To: <20260316162518.GB1767448.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-11-dmatlack@google.com>
	<20260226170030.5a938c74@shazbot.org>
	<aaDqhjdLyf1qSTSh@google.com>
	<20260227084658.3767d801@shazbot.org>
	<CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
	<20260227105720.522ca97f@shazbot.org>
	<CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
	<abNOwcOTXqxCxNzt@google.com>
	<20260313083918.00005731@linux.microsoft.com>
	<20260316162518.GB1767448.vipinsh@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Vipin,

On Mon, 16 Mar 2026 09:28:32 -0700
Vipin Sharma <vipinsh@google.com> wrote:

> On Fri, Mar 13, 2026 at 08:39:18AM -0700, Jacob Pan wrote:
> > Hi David,
> >  =20
> > > +config VFIO_PCI_LIVEUPDATE
> > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > +       depends on LIVEUPDATE && VFIO_PCI
> > > +       help
> > > +         Support for preserving devices bound to vfio-pci across
> > > a Live
> > > +         Update. The eventual goal is that preserved devices can
> > > run
> > > +         uninterrupted during a Live Update, including DMA to
> > > preserved
> > > +         memory buffers and P2P. However there are many steps
> > > still needed to
> > > +         achieve this, including:
> > > +
> > > +          - Preservation of iommufd files
> > > +          - Preservation of IOMMU driver state =20
> > In the interim, what do you think about moving forward with noiommu
> > mode without preserving IOMMU driver state? I=E2=80=99ve tested your
> > vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works
> > as expected.
> >  =20
>=20
> Just curious, are you using qemu VM without iommu device for noiommu
> work or do you have actual system without iommu hardware for testing?

I am using a qemu VM without iommu device and with an assigned
nvme device. I use a low level nvme userspace driver (modified to use
iommufd noiommu mode) for testing.
https://github.com/SamsungDS/libvfn
