Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127927;
	b=4rt7HXJAtFyjqEka70sSIgETAqp4nkaoGGLAxM6EPbj5N2t5uf17Bm6PwaPPYBsjQrOy
	 u6yUb21w5zUxC9ZccgsxdDbif6/HR3kyuDmv9Gdr3Rq03DywsjNRtM/TpFP3O/Ko4Tq22
	 I1TdYWYESAa/vCCxedc5jmCp1aMfFExJlT4JMqQK40vm/vfxJJWHJ4qXV7i2+6PH0L276
	 gC/ILNkAZBqieKWLx51oOvCAGBg2SAc/jHfN/TA3Tdy3QfmTVYVPmBoek0HT5ZzKRd0Q+
	 QHy3SqNGE6VoBf2Et0rpgh4R1oXx+5ip1DB6zqWlnS72KFVge9b5JNk5KuQopsLvXiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dXDGDFZiGAWXcI9vIcz/BhexRx9A2x23MiNmB9mDVkY=;
	b=cMD1WF3zKDuf43MEu0A0hYbk8ZnEapANlwBvVMJt8DaXWsDVbcmRNVydX7WZATZSZWTJ
	 Yfo39mlIyOGXaG1LRJvbFfyUsnGBapB71YF0tDD8xqr1Q1EBFq8tdxqpKNvIkeFne/JDz
	 q5o2qPLB7zp51JIL28ecJ1wDJBudZzT4W0x631CgyGhkvB/2ISihWDfisWAP5vS6yR102
	 tIpdG/OMfHsUiXj7YVgO4+DBmp5GM0s0xHyvjSppcYDrJol3bvaac8qvvDS8XhO/fz47y
	 LArc6aE8/60hmFxsBdSZHfAwrJ83wNOFEP+duEIs9hGX8wiOecPhnPIndJKqpeqf7rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcMHzkQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A578606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcMHzkQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF1D1F000D0;
	Thu, 19 Nov 2026 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127926;
	bh=dXDGDFZiGAWXcI9vIcz/BhexRx9A2x23MiNmB9mDVkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LcMHzkQR10FYbEM7SUCzt7A9/vpN1FpYbTgOnDFynkUW+XA0E8GtsO71s1AVzeKCs
	 jMvg1iLpgkaxuBNF5MNBZrTQuOdTYQ0rYY6aH95XcODHlc2rozHszwOwYEi0bEaOo5
	 7I3THb4pU6mFXzA8HR+MpF/eRWuBUxr2qWpCmS/t7awJyrgEj3QvW5kbv86+Lz/EWK
	 p1DURKbyxIDDLTusatVFrNWnEowQL7C0k8WCh3u3Q0g9fVTV8P6rrNA4Bo64kRxjKu
	 hgQ+wIxH/Kf43hbxv8E/mrS+NklKj3s2ckTQSLGT9HdHug7dRpMOxkvlIBqfM35lYK
	 yWMTVVwk0OsjQ==
Message-ID: <sashiko-outbox-224147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/13] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-13-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
>=20
> Preserved devices must keep performing memory transactions during a Live
> Update. Clearing the Bus Master Enable bit would prevent these devices
> from issuing any memory requests while the new kernel boots.
>=20
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. Clearing Bus Master Enable on an upstream bridge prevents the
> bridge from forwarding memory requests upstream (i.e. it would prevent
> the endpoint device from accessing system RAM and doing peer-to-peer
> transactions with devices not downstream of the bridge).
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D12

