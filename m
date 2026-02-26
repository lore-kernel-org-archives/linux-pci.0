Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70B36EAB1
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772066784; cv=pass; b=ZoM1NbA/t3EOPqqLoe+rWdnYRCjnJLEld2p1JJkwLjZoCEKw1/1YVJkToNZ7ccnkWaEljWA9YvdNxafY/yCZhJnNB6tMtKTvSPBnOhD3/G5a0PYQ1z1XwtsYYLjm0rF/Jb9IxP7bYLDHz0FGiP2WZ3Lq7d7JTpSQ97Ocrt//Svk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772066784; c=relaxed/simple;
	bh=WPcUxRWIf+xdW3rZUp57loGNhqTLwpDKpkxUCRZJXnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frQzNd7XbSIF+KNrYJnGb55tXlX1HAR1qulHFeX9We/YKFZ2jnipj4Wk1kSA31TIkFwvG9VG9v+Jby9nyt02zfWLfi49CqA3FbGwqtlnzBbbE1c+ARXS3EHkvvKBJPgOMsLFKsZRV8CMyJGURu9l+DL/5N8CrF5il1pZuToVsjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RL7yH3su; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RL7yH3su"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56a88bfd4e3so318506e0c.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:46:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772066782; cv=none;
        d=google.com; s=arc-20240605;
        b=jrr8xZEn190vodBIcRkpKeL/bebF+dTOkBNLnAZx/ELIQhlG8vEThDv2/xOGX6J8Bp
         JQ9huFejQe9erNbKesVrutNZ2rcIvbQU9+21EOwh7ex6LsftXJiXXbUXcoPwqkeCHATl
         lz281LXTA4E64cGtUVLDywdn2uN2qjazEGi83hqkm8kU3OJf/SONXHuO5uXVjA+OmomA
         lXxbTDsFs0thtFziEHFatkzFGIQDiM8Lep4qXkvVEY70Ass7zrctvqSGulMOo5CZAM3f
         P2kXKs0hV0pfRaRKyv4vk8GD489OYGLKOPynJFZH3AL+uex67n89Qst4kJZAIEufcEcR
         Gd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ACpb0o7E3VaAsC1KFvr2yXYuV7ohO1EROiDs9rJDa00=;
        fh=xshBrCH3fCLPBYyFc9iw1Ai7jsErtMR4/tMamL5pgG4=;
        b=Md/opInAtBIi3Xc5jZ0bUEuoPzPWISVRaZMN4KVV12MCuP0mLvYedNo3JFqu3y0c1V
         hyr5+nRAbI8UGGHDh1/l9581FgTvuE2aQ/WGyELmLRap4t7cFQRerpBq9fElUJTDAN9e
         tvcVQouhV1aoyr3bu5ZBWyYBjEztxDLCQ+nK59Qy8vLFhJxIcZAVhru7uihu9VAUuON2
         PwcnGbSwCI5iIAhnHWUkZ/jpmsoDSPz/szxdmMTOAFuvyQjGlVLqShtell6KMe3aRTjz
         sP2oZqueTO8vW03kST7WcpIUz88x6aADcvdimKzU6Bb7iLANsehm1y/wZi3gWnq/2q3A
         Kwtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772066782; x=1772671582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACpb0o7E3VaAsC1KFvr2yXYuV7ohO1EROiDs9rJDa00=;
        b=RL7yH3sudTnq/XClkaOpF3fuWXUwGuIqMamfzIbLqr7qujx2xZe0DcpkmcUC7pE3nU
         ZlU5K692jKuZVitqPgrzLEDQZYQk0eJeIbWEkOb2MtLDwVBZ9oYbS0eXyTQ5FNLiAjwc
         FdiVg+nwiFAqo1ov/dnoj5KWN1G6zF5SKeofg5TuwnHMu0KjGZYY/y7HEZdug/q91atJ
         BM7ZNRkC9gUeRWYKt3P3ulTmom2i7kp+/uDLB/Sa8RPZYKUnERBZveY94zFkdLU1HwmJ
         Wogt1NZL2yCAafNB320aJceTY/6MTXu8q5NR/zFWbXLqStgoCH3jMnSWvTD7p0w3ECa3
         eppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772066782; x=1772671582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACpb0o7E3VaAsC1KFvr2yXYuV7ohO1EROiDs9rJDa00=;
        b=DXjIHtUAYl0bHXe2aUpYK5BIoW+ZvKqIV9XZ33Lw6HbrnEdwpZmFl0T+faXVTRzz4+
         Tv5wS4/kdBQQ78LGAY1FvvvER7FWG3YLhj6IYGjsBrvXrKzigidxg10kAk6b2jkolgDs
         IOALpql1PxHc1C3/aXU+6rQByHKhYoUoctbnre5xbXdg6+YZc5CbVk96ffWYNgb2tKLE
         MjU8gub2wMU0bUt4CJoLM6xoMQu4HaB9jCj3SDvTDPKKaThsgOc+uZi0PIAYb+ny+aVL
         qFUgGbzDQPXRvHJA5coiCflHmE1wxOhi/5qlAEEJM2ECSfVKxCrt8ixwSS8EQzk0scGI
         oi8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrD+ljMJa4d6JpkxybIOVYe/hvuIVSi9pm4FuGYdzeqkUZld/Yf9x9AE4jIeQcp6huvtG/mmG612c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJswAfqHv0BoCaZEKvJrl+Z+1rxtdTHTEcR4sNjmnd2NoK7eK
	qAbYDOWPloM6ATLbh2c8kbTeiZyR1F7qSETF3Dz8BwB5tceecvVVyY6iGtAviCxTCIlpwA9o1kX
	cAWoK7OneM+DgX1e/ghzmKUm3xaxlHPz8xoBfXEpA
X-Gm-Gg: ATEYQzwjMPyDQRIbRseEI5zJS7O5B7jWONU69W3O+Du1+L7tHqLIzKvVlOtWd/YdAyS
	Wxja4tHzL0YPTcfEDBnN7To8nzKxQq0qrGU/piYSHHAcFbvyeR9eY+pOMMnZaZvfgq4klYGqf/M
	rpK6vq6VbQZ44t5r99mN8l0zNvGcdic/HNAqShIfDyIgZGnf31FHtdjLqC0bKxtg8LuZlzslnh/
	j1gXbdZNcnUNRwqyjJ/1qOMxafGlxfLlV2omm07dxLsw7gJZXyJKT4n/NgTGIsmDjtXowVyh5tz
	ABppSLo=
X-Received: by 2002:a05:6102:94d:b0:5e5:6eee:8adb with SMTP id
 ada2fe7eead31-5feb2e8f35emr8956594137.4.1772066781725; Wed, 25 Feb 2026
 16:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <aZ6rB-zmpaR3RLB_@google.com>
In-Reply-To: <aZ6rB-zmpaR3RLB_@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 25 Feb 2026 16:45:52 -0800
X-Gm-Features: AaiRm53bfmGZyNFLKGENFMQ0ksttnoZ823ayheFdxpLxg9pxKiAgxb_V1e66-JA
Message-ID: <CALzav=fQtLd0DfWcVku1BDUzcvvYu7MBY+=G7rMMr-gjLUioAA@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
To: Pranjal Shrivastava <praan@google.com>
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 11:56=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:

> >  int __init vfio_pci_liveupdate_init(void)
> >  {
> > +     int ret;
> > +
> >       if (!liveupdate_enabled())
> >               return 0;
> >
> > -     return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +     ret =3D liveupdate_register_file_handler(&vfio_pci_liveupdate_fh)=
;
> > +     if (ret)
> > +             return ret;
>
> Nit: We might need to handle the retval here if we remove the
> liveupdate_enabled() check above (as discussed in patch 2).

I think you mean for the below call to pci_liveupdate_register_fh(),
but yes agreed :).
