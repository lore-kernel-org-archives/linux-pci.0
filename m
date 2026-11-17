Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950185;
	b=cgU6j/BvwYjf1sAmy9jthops9irS9Gz5915inGTDC+ooHMEF2EEhgphWcDXaYKBleWio
	 vpFBvEbVZ8J6MNujtM4K/0tTBOIxXAqcfQyhK9lbT34PlyWnhJO1TjBcipTHDaNizu8WR
	 ADUXAQDergW2FWzOQb45XcymDvY8jAduoVOtRKnziurR8PHQHSVl7xF8/JuSLnrmrz65v
	 KLJQ8FssrhRXiVhg0OjG4wLxNqi9rbFkudoMAPJ93cuNJgVFG5InKvWJ7MxA4CIvLCVUe
	 G+Xz6p8BXK3060+u1bwaU4h3Y96cudWA26H/ehXm8W8Z2X1CWUbjdr/2KWzwnjBeQJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=Ays1EfzTLcRjTY+4yI71x15YxEo2laYpKiSTCWHUOoo=;
	b=IopGMXeyzNGTJkoRQ39EgijNpQtvg0MUnIlCcWBa39mOUxK/1il9boY13KM+AK9cmDIF
	 +EYW67oveBM8zJc4Tazz7FU55CRxSnrNnSW6Frfr61jkwTh/ySU5qcQlIo/PahMqVt6Ft
	 nCz/Qrw4LEMb/jQb7N1OMEKWWfZHqConvwu7HSjUm57SXOXMS+nXjk/bmHAhEGdCvDQCy
	 CZgGZXRyo2eEAdD9Jk0ZNFMYO2fcbGmp3GRExfPD8rSKrLO0Nkpq5v0jCnqI1Bfk/q6xS
	 scoEgQ7Hkb3yAydmhr23ZBr8RdWh+NYYnpFOTA9KSo4DRfY5BANWHDVVzqpQU6yWslg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S9eb+zZ+;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4EB606A333
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 21:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4EB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S9eb+zZ+
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a60f90a924so128968b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 13:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950184; x=1795554984; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ays1EfzTLcRjTY+4yI71x15YxEo2laYpKiSTCWHUOoo=;
        b=S9eb+zZ+PJvunm63i/fXDlCBqZsN39Q9h2grW/i2SIKOr71F+NwBup8zef5dQt+gcB
         Q/0rrjVlc8gUSkw9ZVn3EhHFV5fx2Tm9FW3M8fA4i0Ww3PzuTovXl+iTx9BCBASvwUWr
         pova27Z7YfhEiaxRjzF4dHotz1kC2zngiDdDONWYPDQmPivP3oQ4ytGKGpMIekSGYGM3
         3FAs/qBVWevcJX2GmN7YxTm56VsKILYGaDVDI4AeaxrcywybDiXOgsR2HYISBBCTznCb
         Ka9llwU/+pcYfEhEoANG49K58AY7OFrkbMwVaDPlLMxHF6QpnNJ2BOd0wBZvfFmxEQK6
         B8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950184; x=1795554984;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ays1EfzTLcRjTY+4yI71x15YxEo2laYpKiSTCWHUOoo=;
        b=gU4GOUtP+Fw+JAxz6ol8B1pZgGo5E4X1RPBULKwYvgWoZSHMJn197YrZgxnPYQViRu
         RdQZxyaFy6FMm6Ansl07HGdycJcBX8ACM1n6rSgsOYJ9iHqzjDHiIkBcIDypPyO/3ySq
         gYva+AOPgGVTU5Xm5cD3ioLsMshnVvhY2GCD9RWE7knajPp77qaSsRl94I2RmDQ267Fb
         nmHG0kML8Axt1zzV3w2JF1j5OgBbGJ/fFxaayVD1zjDZ4xFUf6cjxjqw12R9PxxWFD1Y
         qSR7SN3+N5pgu/hGas2Q1ljNMY4Ljrum7+KtJOY4LTP+kXvYxkVR+vFCLGd8WYrI4FRU
         FEcw==
X-Forwarded-Encrypted: i=1; AL+hErGpsPMOOmB0aV3/7s8v4YAY6aw3h6Uq/ASkKxOKnPHlmae3mUCfqWR3mHmIwLwDmQnaPzUsCim/+y0=@vger.kernel.org
X-Gm-Message-State: APuU4Z83iKtvhHJzxiZhgrMKc0F1pItwcSS+eKSeablh9p3dX/gb/6Ke
	XMDs8dg3q4fB320+YgH/3oVnXOpcExDKmr8iGbaWfU0I3ScawTSHINzF9665jQTDtg==
X-Gm-Gg: AZFdTZf+Au6OJEAz4zAl6E9j1Cx+APVty47z3FepKc6R1GkuAktqMtA6fiMfoip2V9R
	n56/OELN8pjOUe1Che9sf45ckeDhpsWW4k8hcw3SWRBJjgKUnBBkgRw2EEbaYvN3/FSbKCioWlw
	kyu+EnjMhW4qa/AIdq1CjJuuand1pD1ITjyrMB5fvTKmONT52SG1uDxvqQ3iPSBnML2QYSVtWdj
	txJF8vgwjRslAJ9wW2mQmvriRp429K4t9XV28JWQBveaoGIwgt380SE48TYiFaymyUGEulQIW+Z
	bLEGAtFWCHUsqZHSELisL6zc6O54n2usq/c8Fox7j9f3dA/ATasi5uf96wJ+yWVn+Se5RulDx1r
	b9m/4++iOcpHTQ3rbVM6Kq823MF2K9EDxui0/gs0iKI/Efi3q6EjoD5ZJSTRmsxKktMWV8+GxMO
	aYLyWLAVBZ6Hcg9JuZwpeIXF580bxFN03CoPEofRA2Q+SL3VFAUgHCkoAtt/6KdCYsOwTp+K401
	4FT9nY87bpIZ7o9mUiXJ+OqvsGQKOC61eyvmhbxVpZcQJngK9emCY3/vVcInL9rEIuNZi4Oyira
	xuBs5AVcr0+kTTgbFSlTnnZNUEzrgo7XziPP0IdqQnsvm5RYqE81/JNcKFNUY4ahJ7BFReLPnbP
	emt9Qb0ktzA==
X-Received: by 2002:a17:902:f790:b0:2e9:460e:ca57 with SMTP id d9443c01a7336-2eff7529757mr5030915ad.15.1794950183338;
        Tue, 17 Nov 2026 13:16:23 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff61841aasm2714705ad.34.2026.11.17.13.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:16:22 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:16:21 -0800
Message-Id: <DMXSQHZG5L27.2NIIT7F6FW0ME@google.com>
To: "Alex Williamson" <alex@shazbot.org>, "David Matlack"
 <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava"
 <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
From: "David Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-10-dmatlack@google.com>
 <20261116170942.720b06fd@shazbot.org>
In-Reply-To: <20261116170942.720b06fd@shazbot.org>

On Mon Nov 16, 2026 at 5:09 PM PST, Alex Williamson wrote:
> On Tue, 13 Oct 2026 16:25:25 +0000
> David Matlack <dmatlack@google.com> wrote:
>> +int pci_liveupdate_adopt_acs(struct pci_dev *dev)
>> +{
>> +	/*
>> +	 * Check if the device was preserved over a previous Live Update (even
>> +	 * if it has already gone through pci_liveupdate_finish()). This ensur=
es
>> +	 * that the device continues to use the ACS controls established by th=
e
>> +	 * previous kernel.
>> +	 */
>> +	if (!dev->liveupdate.was_incoming)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The previous kernel should not have preserved any devices that
>> +	 * require device-specific quirks to enable ACS, but if such a device =
is
>> +	 * detected (e.g. new device-specific ACS quirk in the current kernel)=
,
>> +	 * log a big warning and fall back to the normal enable ACS path.
>> +	 */
>> +	if (pci_need_dev_specific_enable_acs(dev)) {
>> +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
>> +		WARN_ON_ONCE(true);
>> +		return -EINVAL;
>> +	}
>
> This looks pretty unsafe and the comment is only explaining how we
> might get here, not why we shouldn't panic.  IIUC, the IOMMU lho
> support requires singleton groups, but I'm not sure what it does if a
> group becomes non-singleton in the new kernel (such as via a new quirk).
>
> Is a warning related to what might be a parent bridge rather than the
> endpoint device, really sufficient here?  Thanks,

It's not necessarily safe. The new quirk could change how TLPs are being
routed while a downstream preserved device is still sending memory
transactions.

I think a better approach would be for a preserved device to always
adopt the ACS controls left by the previous kernel, and keep them
across resets through the ACS save state. So a new device-specific quirk
for the device is ignored, apart from logging a warning. IOW, new ACS
quirks only take effect on cold boot.

If a preserved device has an ACS capability but no save state (i.e. the
allocation failed), then we can panic, since its adopted controls would
be lost by the first reset..

Roughly:

	int pci_liveupdate_adopt_acs(struct pci_dev *dev)
	{
		if (!dev->liveupdate.was_incoming)
			return -EINVAL;

		if (pci_need_dev_specific_enable_acs(dev))
			pci_warn(dev, "Ignoring ACS quirk, adopting ACS controls from previous k=
ernel\n");

		if (dev->acs_cap && !pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS))
			panic("%s: No ACS save state for preserved device\n",
			      pci_name(dev));

		return 0;
	}

The panic would only happen if allocating the save state fails. Ideally
I'd like save state allocation failures to cause the whole device setup
to fail. That's something I'm hoping to do in the future on top of the
pci_save_state rework [1], and then we can remove this panic. Until
then, the panic is constrained to Live Update, and the allocation
shouldn't fail in practice.

As for IOMMU groups: Sami's IOMMU Live Update series refuses to let any
device join a group that contains a preserved device, in both the
outgoing and incoming kernel (__iommu_probe_device() fails with -EBUSY)
[2][3]. So if the new kernel considers the path less isolated than the
previous kernel did, e.g. because of a new quirk, the group grows and
the IOMMU core refuses the second device rather than putting both in
one group. The system comes up with that device unavailable, which can
be debugged and recovered by rebooting, instead of panicking.

[1] https://lore.kernel.org/linux-pci/20261106004218.604799-1-dmatlack@goog=
le.com/
[2] https://lore.kernel.org/linux-iommu/20261110040828.1774343-6-skhawaja@g=
oogle.com/
[3] https://lore.kernel.org/linux-iommu/20261110040828.1774343-13-skhawaja@=
google.com/

Does that sound reasonable?
