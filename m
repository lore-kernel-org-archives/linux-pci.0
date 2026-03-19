Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470538BF61;
	Thu, 19 Mar 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938382; cv=none; b=q/Br8HjmborIltSyhLoancfJ3NhMhV6ePkEXswFxsS6ru0MXtob26LJBIkHVCN2QWkUDnMgQHTmXTCkRZCRrAcGEUsQoOEQSCir1EBmqKdjd9+IoFZ155ykIIEdvJ2uihFRNEiQqdC4m1moJOw7TvdQEbtY1K+tN1ovjUvbLa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938382; c=relaxed/simple;
	bh=Y+Hv0DkWk/c+ewBI0ps5vOPQ63BNCB7+d21mTtAJtvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNkVrqjoCvIDbN/TAyMzvanvlwP9mV0uMYMMIk0HyHYLRP7eNrAnBlRgcDJxyUuOHA1jP8lbqjwzUWDq6jntF3dk1C+odb+9gUnQBTQV5zr/dqnxgj1OmrSpcIEfU5SVy5d7vYc7OX7WJEMrGacHGW1AxJW/G3UhSJVUXk8ZULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bmMuGENd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bmMuGENd"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 744CF20B710C;
	Thu, 19 Mar 2026 09:39:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 744CF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773938375;
	bh=8r3Rrhjz62mzvDnQKQk9Pz54iwWA+pJBFG61+YWArBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bmMuGENdC7hPcV8u5wKM+LeF+mgtVIFSJy2h9p6W0i9+tl+Hp7PwExVnUfQO1xHwB
	 Ouf5VcCqaSQUs5qKCHuxTDWMmMZ137/dgQcmFiu/HC6R4d58LdmNNYeQegg7/tAA4c
	 QVfQmqGCCPaKOdhfIjpxs7czL0tSUxWhHGO5GW4k=
Date: Thu, 19 Mar 2026 09:39:32 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro
 <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, David Rientjes
 <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke
 <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
 kexec@lists.infradead.org, kvm@vger.kernel.org, Leon Romanovsky
 <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Mich?=
 =?UTF-8?Q?a=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport
 <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta
 <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Thomas =?UTF-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu
 <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260319093932.000078c2@linux.microsoft.com>
In-Reply-To: <CALzav=eGLpo5nrsHq5L8bUTC=FWZ-SgrTE1FoScrWB4p+NDgnA@mail.gmail.com>
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
	<CALzav=eGLpo5nrsHq5L8bUTC=FWZ-SgrTE1FoScrWB4p+NDgnA@mail.gmail.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 16 Mar 2026 11:11:20 -0700
David Matlack <dmatlack@google.com> wrote:

> On Fri, Mar 13, 2026 at 8:39=E2=80=AFAM Jacob Pan
> <jacob.pan@linux.microsoft.com> wrote:
> > On Thu, 12 Mar 2026 23:39:45 +0000
> > David Matlack <dmatlack@google.com> wrote: =20
>=20
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
> > mode without preserving IOMMU driver state? =20
>=20
> I haven't gotten a chance to look at your noiommu patches yet, but I
> do think noiommu will probably be a good way to develop the VFIO and
> PCI support for Live Update without blocking on IOMMU driver support.
>=20
> > I=E2=80=99ve tested your
> > vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works
> > as expected. =20
>=20
> Would you be able to send patches to add noiommu support to VFIO
> selftests? That would be very helpful toward allowing us to develop
> and test Live Update support with noiommu.

It is included in the noiommu patchset; the only difference is that the
VFIO cdev name is prefixed with noiommu, which is not strictly required
and is done out of caution.

/dev/vfio/
|-- devices
|   `-- noiommu-vfio0

https://lore.kernel.org/linux-iommu/20260312155637.376854-10-jacob.pan@linu=
x.microsoft.com/
