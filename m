Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29ED39DBE3
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370796; cv=pass; b=Vdh48H2Af9IT0+gF38Xrj3Qm8jLuVaaEekSwlO2N0cJhe7m6bmJxyF2pUmkRwFYTB0wHNyEoTf3JpKCEpoFVcVEN8a/SdHpnS++S4GoVvHPZwj9CwN36vF/v/y3LnkL8ZRtHlQlZdBoVGxWc0YU8MPh8/sm4aUY4qzAl023srj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370796; c=relaxed/simple;
	bh=kRBNZYBXvdyd0G3IRhmHcdN/BFg2bxldCxeHP1r/m7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYy5KtfrQjPuZNNhSLzWecIZ8aFpyscRAufHy90eoFU2fY6fvDXt17WhdvWo5zDm95svi2Af7CQD8l0JybqEvXAps/wS7om0hnSln1eZ9hADrcFctGGnDjFUokvTFcy4/hafSilm9lpgqkbFUpA7WtQ3Y4yzviogbgFDbHxAW8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4sO8PKp; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4sO8PKp"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38bf132993dso12680101fa.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 09:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370793; cv=none;
        d=google.com; s=arc-20240605;
        b=gzhGr8vvpGLWpMH1T6T8cuSgAi6lwPu6v9RdXN3lBA3Xmi/rJbSnb6OSFBO7LPc6KG
         Mz7qYsMSjT7MqFRfJodDP++mpJQfcIEmdUKMfB0BRo5gDQbqhfm4158EiSq6kCuLm75w
         QCVIE1JMbsDwZzDFDk7zyos9SRpzt+MzQF6f9PhwQRL+YBOihn2nV4tyh3q8ly7hPkBR
         UvjzPfs5F7LpnOpzBwfGZmJR72ebA5SAyU7LKdQccOOqdwewiWrpsf48DCjoe5Bs7z+N
         stJuBOsEd63OgLFZVnQU4i6gmgIkDe8nfrmQhuSQZlWrsjy5WAZkkJS5E2LXJr6fagT8
         /bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        fh=/Ne9ASZu/LNtT+UXu2U51vOzEe44t/i2YLytZtXJk50=;
        b=lAY0uHgbWp/vUthTeTeG09DUpsSR/YmbEaYoYWB+1jb1KRlWjVHLK+z5kth53nRDq0
         0H/uaTC9TMXkvvOA/6fRHAT3+tYrTx5dSnTV1BeFKNET99lQWwAJ9QititzupSYc8WOD
         Vx7BgyjPpaJXWOA7HQAo6d4snMlPpikOlsAltu15g8z0xGCJHrd3bVkssBe9gChmamet
         Zz+VZbd4zf/g/GmK+z5aQH5SQp+Fro7fMunGkQTdGzX8b+bGpNaEUKg65uufMt/Inpl4
         banByPPElCbXb78YVkNEhbO7voEvxODdaTfys5ikCnEU8NamRXuHpgO2PQJPap8s7+Wv
         eGCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774370793; x=1774975593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        b=H4sO8PKp9fcAPhpWTxNV+tFmYJ/sEMYatbvIzld2dPiEOMw9aGpQ+WGNGjATEm+51/
         YbUcXFrcz97hbxrzxsEftuOqLKQiOSrFXG8T8HXyVGKMdQx0HKHJye0LmCsymPDZPSvG
         M/CHqF2rcTta7qW3KZgb2NMHPAsk5WrMBrhk43stRUaU83lXDhrC0HIe/9Bl1cZQ4HWb
         MFIwP/f7Wk9f1aXFttOJmUlBwtLno++Ijt//Yg+3pVY62V59rXXtcCnbpzbyAluM8rv4
         cpGGN572WnyszDNQd0dUYDT9JLIypM2+/qb1F2bL6BWSOgFP/9k2jDhbbXODCuJNqqJx
         AsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370793; x=1774975593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        b=bRBajUKy9b47RPPNbCEBn9sh2HygFVy/fNNOUwVHqQBGff/h0lKhRuCIiaCBj8GRqw
         wlZyOoxmnKdvjFY4gFfqaPZTYU2JiUZm5CsRjMEhnYkGOCHG3IMOO5t4qZRjGewySiae
         tHXl+rXpbr9TwRHMikDPUBQf+tqR3rGbCrVS9n9w76//QPO3XA3BS2G2WAcgSXStR85H
         DcyP+6YTN1iAzThX/l0Lk4QPZ0mCOT1dW6TSyrvbrYbYoW39tBiHRp6Ft441stVroTB2
         PX+lMuYjC2FKmf2dN/NtUUhQ6lqg4CHZrSsF8VR3C7U/yOGcYTZZNNNnHoKfSwoYS+XH
         Kl2g==
X-Forwarded-Encrypted: i=1; AJvYcCXgkE98XbgCCWERUHlSkOkSyxnYYC8RH/VzW/5XgBqCBPyjpSEx1wcr0Ou6KMioRIjaTGCT6x6isXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjS2JsZYE1Oo35356jCrJciXpEBMnfdJQ786FGh9ujTOp29P8o
	kNlt1U1c3Rc14T2qI2WaJS4FhLbNI3BeQ2lChUPn7z/WXJa2vcF8Pt6U4a8QQgKld5YF6+Wj4rK
	Qr1y2VXgRM+ft1rBlUfB0ORX8gG/nY23ye0rXwcAV
X-Gm-Gg: ATEYQzyEkcTn+1Wrm+D2UyV75b9Nanfv+B5tpK3eK2OFPO+4r9h/WSDADvySrt26E50
	Yv0wxXCyFYNm1icDNICPIb4ZsPoru3aPFgslSu2nwFO7uQQqq6pAVav0/IEjRRieOlTOnXnCM3N
	b9vO9852Qhf63MnXbocNvzSiwXb3GkZUTy55OvtlMMbbOY2dbWvlTcGRxrkG2TB+YyIHX1W0R/I
	S7xS5i/Qpd1pd07bwIGHDrsiqQ+zUzHcl39G71xHZlMgER8lXLGnqzw9es+sXUgHGDGx+E+9l+v
	I9kjVaII
X-Received: by 2002:a05:651c:198d:b0:38a:45d6:c246 with SMTP id
 38308e7fff4ca-38c4309f785mr403821fa.8.1774370792285; Tue, 24 Mar 2026
 09:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-8-dmatlack@google.com>
 <df5dac48-8a54-49e2-acb8-9370b7078033@intel.com>
In-Reply-To: <df5dac48-8a54-49e2-acb8-9370b7078033@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Mar 2026 09:46:03 -0700
X-Gm-Features: AaiRm53x8nRAyhq72BKXQ8vBk2jNU8cpC5QwT_5hu3qjlEbsk36YMzg6v1f1PaQ
Message-ID: <CALzav=cGzzZTL-tyaaG_AhC3gP7ULiU6hWS=X6joLTjyoo-6sg@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 6:01=E2=80=AFAM Yi Liu <yi.l.liu@intel.com> wrote:
> On 3/24/26 07:57, David Matlack wrote:

> > + * Usage Example
> > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + *
> > + * VFIO PCI devices can be preserved across a kexec by preserving the =
file
> > + * associated with the device in a LUO session::
> > + *
> > + *   device_fd =3D open("/dev/vfio/devices/X");
>
> /dev/vfio/devices/vfioX

Will fix in v4.

> > + *  * The device file must have been acquired from the VFIO character =
device,
> > + *    not ``VFIO_GROUP_GET_DEVICE_FD``.
>
> how about "The device file descriptor must be obtained by opening the
> VFIO device
> character device (``/dev/vfio/devices/vfioX``), not via
> ``VFIO_GROUP_GET_DEVICE_FD``."?
>
> just be aligned with the below words in vfio.rst.
>
> "Traditionally user acquires a device fd via VFIO_GROUP_GET_DEVICE_FD
> user can now acquire a device fd by directly opening a character device
> /dev/vfio/devices/vfioX"

Thanks for the suggestion. Here is the wording I have for v4:

  *  * The device file being preserved must have been obtained by
opening the
  *    VFIO character device (``/dev/vfio/devices/vfioX``), not via
  *    ``VFIO_GROUP_GET_DEVICE_FD``.

> > +#include <linux/kexec_handover.h>
> >   #include <linux/kho/abi/vfio_pci.h>
> >   #include <linux/liveupdate.h>
> >   #include <linux/errno.h>
> > +#include <linux/vfio.h>
>
> maybe follow alphabet order. errno.h would be moved to the top first.

I will reorder errno.h to be at the top in the previous patch (where
the alphabetical ordering issue is introduced).
