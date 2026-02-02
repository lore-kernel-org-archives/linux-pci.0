Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95E2D8DB9
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056128; cv=pass; b=qkEaFETvhLT2nW+2ToBxG5gmvtEWKjWGNXq1j68yANxb3HQe23Ok6Qk2cL3wgRczJf64enweUg+s9Mle7Wsp0dBLTwuxoE6GJ4Zg9kLLxhPlFGhrwuC1PGUopRFyq5RHH2mM2U92pUUrvFCg0qoxDfj8EYvjzX4u9xjyEpXApwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056128; c=relaxed/simple;
	bh=hfLkISPUv1gvXr1CboqWBn1bs3Sd5IoZNOLzZg55skM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iF3+Vcj9hY3LFdVkbqT7NpezdvuXAj73tke4Ebb5qL/3YekiQctX4+cJoZ5yWpqzrbFupi+5+yM6Y0cB4Qa1MnYffbUi487OBQ5S2WCMOpDgRZUO8+Ne/irZGx2WCaWqo38gfpfQqPkpphWIM+XEm+iZ8HvOyYRXz8EcJ7UhPVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSJ2pVDb; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSJ2pVDb"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-385b9be0759so36824891fa.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 10:15:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770056125; cv=none;
        d=google.com; s=arc-20240605;
        b=amy8Zi6GSXF1ZhyuMtlZ94bHLNT1QeqhaKBx3MLGKW0DNuS4BspOLblxVeNigJ/4Qy
         nLmns9chstwGFEYo/RtANTNM84O9+t49qsTx+x9P+GZO7VxbZ8eu1+6nf5PJ4xk/vUqx
         g7aUpVGKOywrP386uurcoJuYx76s8HNTOYAgwg1FcbCXC6PRcQvv2EKXirs1j/GE8wsA
         Du5N4s3RWkvwL6alUKSl3LnwA3mN7DYCDhpblgD9ugxZdtBuCZuW3Xh6u/rlBB9ghPtD
         kGR52HuAc2uuiOAcTk3xr/xRxrw0kb2AZfddtmEAUNb2eWKGUJDNKCi0uzVbTHvTqWyz
         33vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LIHmbN0vtM4SeA7+jGmffdOqzfQaVyhc47MhdLc1+1s=;
        fh=ToXhNDChbhkxxwJdrg3VWx7nueusGUcVxxmg9ik98e4=;
        b=AMbWoKoAXNf+cFjeYCiVIQec5EtRwhI7cxIdn9kfeSjYBmF4knKZmY9ym8lByjo+D7
         8SrTCLVQdzRSyfS8xFvhHdEp431oHOW1WwYFsNCh+S36oCNDP0G3PnjmqCml4kMSaRKP
         /JZufLNTVw+I4N30QqV+MI3MMlij7rwpJNtrb8HyNZffB3pN2eFrqYUIydXzeRE/tl79
         L3x9CB6vzI0Eu96sTJut7kKSz4p8B7whgKfNQ8H9bZPm/DuMZt4mQ5/fLJi1MWIgnUO8
         I/DyJRp3WLW27P5oWUR7ZRUELJplhDp2ftpipBMpemWBs29sfYo/6KqbKSidRX5q1u/Z
         MVrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770056125; x=1770660925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIHmbN0vtM4SeA7+jGmffdOqzfQaVyhc47MhdLc1+1s=;
        b=PSJ2pVDbNQVnPXrXNjymko4FOE40C743kvBmJ86NLSh4GircZENoqWveK5OWNMFOO9
         GpNsC5mwmhTxifUlf/daWGwYTrtNmBzSI9eXvPrODcez7DbDVIYiqvcyBy8amLYrrxVp
         DLhTd6QbiVH1AZJlMuR6iTv3Niiaa2lm5P9p2E6o7tcArvBjQTQzHxA7WxzzMWq7visY
         Ddj+8fe+ab5vxCLuvIu9gW3nb9y1abZAGX4BKFdWVZfyFeTp3yFB593U7yT/3WYrmVXT
         hClbGiN6g1pDtf0H+z9QDhit5pfuUP7PHyl+0qS9jvPbM1Ti2diqJ0edF/uO0rC2wXpJ
         ZfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056125; x=1770660925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LIHmbN0vtM4SeA7+jGmffdOqzfQaVyhc47MhdLc1+1s=;
        b=GdsB5sqkLUnazg6cl7Qfdlkv6w4LPzP/6/BN4ERalv13InYPulesXnoSrkWl+mnMme
         I1pOiODLuiO1DF7WedUe1CUJ/+yLdZ1JFNv0s/BJJvWSGik8hbS67Jtwj1l2n+lhMC42
         Z03dt49sl2mrJ+HZPVcdVYye4eyenTWIBcwI20pic2exJ4OXafQhYqy+GrBSGcszcaLx
         c+eXFEuKLRVuE6JL47tAC9FnkaK817YY+amd4um49oYHM25ynUv9r8xdZZcljUERDcJe
         RDCaNG46xa0zHhrsU/f9vEnngd2kkORo1zo64lTvMo9hnSt+RCCBKHXsIaSXnTEbu3bX
         NcWg==
X-Forwarded-Encrypted: i=1; AJvYcCWVKN8wwXYZQF+CDbd91FUnT8w/+YWe7tDJJQIzTQVruF5zyOExfEcnhN/4qXiSUGpQk3liTXCaCOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDC1E3MF+pCSIjdpSgCEiWLFqi1xGDdG6ijwIiKpRoW4xsbHA
	Yl3jEib8JKbNW6GggxfL8Us/JRRkEtUGG62oq203NXNeLAq3Aiq1rv4/wI7nxEKJNChBuo8AuMS
	Yj4/PSPzok/aXP8ASK2F5bawA/IAU4uWZSatOvi2f
X-Gm-Gg: AZuq6aJbJWNyJvuW0CfVjZQgkNEXXmBEwB6/m9ak1IFdV2QUj/3JwiCC5EqUAN1mq24
	IpbmdrZie1ZjanUnLD4vtORoOJxG3wqUb+cNU86eYts+Z05NUnnWvaSktFPn9/dMSfkQIsocyXr
	/OhrYtPri16+F75FYxwGxuVWx+ZKxt065Cd8mzWovaQnRhBkF2MyDCQixDfGZ6wrpmP1D7OkTzb
	zNwATbYj/xVQAsjH83HxneSuh6pZZFMvHMCQcsckIgmbPAV9LhzBOKqZMI7Iz7vI8O/1A==
X-Received: by 2002:a2e:a54b:0:b0:383:1c18:ade6 with SMTP id
 38308e7fff4ca-3864662d728mr40696471fa.20.1770056124374; Mon, 02 Feb 2026
 10:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <44484594-5b5d-4237-993c-ac1e173ad62e@linux.dev>
In-Reply-To: <44484594-5b5d-4237-993c-ac1e173ad62e@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 2 Feb 2026 10:14:56 -0800
X-Gm-Features: AZwV_QhgTJZ7rnxODmCU1qhjsI1pWSHh1k-rPTozueyr5OUveeJ2FC59ISanCNo
Message-ID: <CALzav=d1ZrHrWd-HhZJ8aY6aqxkBcLoet_5+-LL1mOakVTj6Ww@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 10:38=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
>
> =E5=9C=A8 2026/1/29 13:24, David Matlack =E5=86=99=E9=81=93:
> > Add an API to enable the PCI subsystem to track all devices that are
> > preserved across a Live Update, including both incoming devices (passed
> > from the previous kernel) and outgoing devices (passed to the next
> > kernel).
> >
> > Use PCI segment number and BDF to keep track of devices across Live
> > Update. This means the kernel must keep both identifiers constant acros=
s
> > a Live Update for any preserved device. VFs are not supported for now,
> > since that requires preserving SR-IOV state on the device to ensure the
> > same number of VFs appear after kexec and with the same BDFs.
> >
> > Drivers that preserve devices across Live Update can now register their
> > struct liveupdate_file_handler with the PCI subsystem so that the PCI
> > subsystem can allocate and manage File-Lifecycle-Bound (FLB) global dat=
a
> > to track the list of incoming and outgoing preserved devices.
> >
> >    pci_liveupdate_register_fh(driver_fh)
> >    pci_liveupdate_unregister_fh(driver_fh)
>
> Can the above 2 functions support the virtual devices? For example,
> bonding, veth, iSWAP and RXE.
>
> These virtual devices do not have BDF. As such, I am not sure if your
> patches take these virtual devices in to account.

No this patch series only supports PCI devices, since those are the
only devices so far we've needed to support.

I am not familiar with any of the devices that you mentioned. If they
are virtual then does that mean it's all just software? In that case I
would be curious to know what problem is solved by preserving them in
the kernel, vs. tearing them down and rebuilding them across a Live
Udpate.
