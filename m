Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764C378D8A
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570735; cv=pass; b=bVKJc89ce659UYZ31YxNSsJ4Itl/Xcp4fUEteG5Z2mLRN2ZBdjZSGkwjgg//xh6eNG6LsDpAKRrQpFsuLPjumiRHxI+0j6n8WDKB4r5Mom91CUWGNJdo942io0EOUYrep2NG2YBYNxZ0p8NrFndOihn+lCzG5le8FAVIZHj3vuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570735; c=relaxed/simple;
	bh=AtQrPMl91+yYtI9BLCPBjsG0Yu7Rz7PLsn3mJ6H0/pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMVgxP02UqDx8gDoZB6QnWpbwPtrHRio75dSfSY5JnBts3Kju8aot9XqP6ik0QpP0TO9uImpMwsThHLQAgM2hjD3jJA3+koZKsWbGjo+dpWUKw18qYinwM5smzGWjCDbg3dvOmIDLtSvatA5J0TsXsR9CCYd9ubk36wUf8psS6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tC9vtssF; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tC9vtssF"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293c683202so161085166b.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 07:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789570732; cv=none;
        d=google.com; s=arc-20260327;
        b=bdnt9EV/Eqbkcx6hNXP0Jk8Nn475pIxviRH9win16lAfsk3glb0h5ny7endMIeo9J6
         QSMHXtpngLZVa1lkgO1m00oSK+kPma3pGSyeBCChe3hGMQeZXZA9FMzTdb5mywlTSlEc
         Oo5WQNPArjXL3V3aJNw+o3cYYJeAplpu//efEDtvxIA+E3a+r2K1ZZybPYNakKH37R3R
         ud/e32h4R9KhUsnuYuG8Bwj4psR+s3LF1tdvl1y0uBrb/5MWgpbpEEYcRuVHKWYqUsEg
         RCPUVZ8MpWKAytFQ0nd5mwAI7KZPfkZNWsW3CXzVYaqTDlKxcfCglje0c6ws0QBS+wa+
         gPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7B8AGM6usS6/DkOynGbVPS6pps2aTMeSLXoc/PLBLeU=;
        fh=kfykNxOR8eoNWw3Nvlziwn2SW1uoWbkcUrV/SS3yHJE=;
        b=KEFTIRC6LNlh5a7U5X/gmb//RTV1a30HlRav7lRJubo97wUNfDet4WyTUp9RWljTbT
         E8urHEL4RuIESQl2Txl15KqLGfBx47QoU8ZvKtukZpNk942+/s308fZ2SVFbUUBGfqUU
         w0O+K4vda6bzwufhB8CUeWMvJXk/WGKb7T62BXcBSI8W+oYKDFQnY8Tsw0sUpy04ZJgm
         FQhJ2cDNmA3B4wrUvLN7I+tCbuGjjsm+03gGRi85XYr7l8FkOTJc5jut+20hBr3e7Z28
         qGkUIvUNbuF1dCmbHNkQUquhCYXIp/+9RLZ4listNamkywVU/+uTlj20bjtpvFYDtqjQ
         Lucw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789570732; x=1790175532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7B8AGM6usS6/DkOynGbVPS6pps2aTMeSLXoc/PLBLeU=;
        b=tC9vtssFRHP7YED+FiQg6pv4DT0aIDonO37ZnVDyqUCZ4dDzQxv+1bkP0tBwBwz9jQ
         cxBqDzXFyUOHth5/D5GyZH2n4VowYr+UEMZAiQLADVITanuFCLAHypEsyNrmuCIW91Vp
         eB4V6JFk06jQsBZRm6hKm53FuYMf8BuPCD/jSFAw489qhtRtDOVL8w4kRcWtVBAbZh92
         UiZwp39dec7eDR/ccqOp4u6GWLVGou//a8negWu75Iy57yVz1WhRHakEqjnbw2R6DpPp
         L/vgXxGtmn4DDPDiW2UUaCPaOrtIJYiuNM9l85x36q3GS4BTJXp6DfIDMxt4OVcbUFnG
         2eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570732; x=1790175532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7B8AGM6usS6/DkOynGbVPS6pps2aTMeSLXoc/PLBLeU=;
        b=D4qPBWDfjgp2JkHta/VNJDNx5CEB6M8KKDtqDb4+znW9bc0Rzl1mrdUi1Y1bvJ375l
         mJN/3vsRLIiV+vfx7Zu7pr0t8ZPGWKLPO1v3BFsCurLHe9TLePPo/Wn4UgWJ3kJunPdu
         Szt5THLhA2itcHfHgc6mgJ6/20CYy1aryGspN4y4WHj27exMI139TVJVStjticPYCn3H
         khJzl+N4i3xMNg4Gzy3jEpYP/APMEMOGrzuLcWI07lmJbBelK5TSL/ioH6KAGFfVlEWg
         IYGh1u94txUmF9o6UcRqkzuGWtPP563LgwacV5NJno41VeS8YQe1joIsVWIckhHG+Jkc
         /qfg==
X-Forwarded-Encrypted: i=1; AKwUvBzT07ZzjByLY1flCuLtdod2CqeQHTAhmpjABY0LvMyv4BxcY3+xPNX2BE/iNAe5dkEmW6ddQ4A2Es8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6hpbzTwXE+EJYTaVoIeIVKrt9QubqBEwxMIX1esPi2kACRZPY
	u14Pn85i8QVi4LsrOyXeLyZkTUvaOaA/miVHAlfEdg5qzJZtXu3NyQi+8K14wjznipikDZFJsEy
	k+ylZ7NepIEaE5nTIX1Hm1MYnPVQeAzlsA7pvcaHv
X-Gm-Gg: AYBFou2E3d0Kk/T4OO6KT925FDcESs2QU3yxTWwpUcXkJYiZ45B4imL7ykr97O9zI+z
	MEWNkbTTrj6uDl6/lvwtjZ9V6rFzjPNu/oA7OPAzdIi/uaHSzVDdkynRCjcTl2wPZ88cUPWGSDg
	o8QcjZCUdIJhtnFGCVG+/mV1zB/RwROG49ZIVAVhbVAA3hpmNj/ppMu9fmzjCdSaKJ7ogPK/DP9
	3TuZR1ENcevGu7GxugybX2Kt/GXRFP3wL5oOkczSoP3jE3KONNjTxOuWhdYirJQBc4b06kPCjh0
	O94FWuwcMoHB2mMsL/ZLpSSq0wAUibvUD53vxtrluaeSOLEM8HMxXhM=
X-Received: by 2002:a17:907:c49a:b0:c28:fb3f:fe20 with SMTP id
 a640c23a62f3a-c29e52c71e0mr199279166b.30.1789570731516; Wed, 16 Sep 2026
 07:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-3-dmatlack@google.com>
 <9211b2b6-9fca-4ef7-a141-84636d56e67e@linux.dev>
In-Reply-To: <9211b2b6-9fca-4ef7-a141-84636d56e67e@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Wed, 16 Sep 2026 07:58:23 -0700
X-Gm-Features: AcwNN1V694h9Klbei55CjXCXrLccfSPzJ9ZF9qWXraB-n35v9TC4KupB_2aeuGo
Message-ID: <CALzav=dJUiZe+Hxck9X+kKVXoRn-Ks2WxV7B5i0RHRFGy7-Mpw@mail.gmail.com>
Subject: Re: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI devices
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 8:10=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
> > Add APIs to allow drivers to notify the PCI core of which devices are
> > being preserved across a Live Update for the next kernel, i.e.
> > "outgoing" devices.
> >
> > Drivers must notify the PCI core when devices are preserved so that the
> > PCI core can update its FLB data (struct pci_ser) and track the list of
> > outgoing devices. pci_liveupdate_preserve() notifies the PCI core that =
a
> > device must be preserved across Live Update. pci_liveupdate_unpreserve(=
)
> > reverses this (cancels the preservation of the device).
>
> Hi David,
>
> I have a question about the pci_liveupdate_preserve() and
> pci_liveupdate_unpreserve() APIs.
>
> Is it supported to call these APIs multiple times for the same PCI
> device? For example, a driver could do:
>
> pci_liveupdate_preserve(pdev) -- > pci_liveupdate_unpreserve(pdev) -- >
> perform some operations -- > pci_liveupdate_preserve(pdev) again, before
> the actual Live Update starts.
>
>  From the implementation, it looks like an unpreserved pci_dev_ser entry
> can be reused, so I wanted to confirm whether this preserve -- >
> unpreserve -- > preserve sequence is an intended and supported usage.

Yes that is a completely supported use-case. A device can be preserved
and unpreserved any number of times up until pci_device_shutdown(),
where the preservation status of the device is frozen (see patch 10).
