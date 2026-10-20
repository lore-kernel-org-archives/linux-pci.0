Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518593;
	b=sR6ZoQdqVF0rNHKoLb+ZX75Y9sZbrHKT2zU33O5GJf94TjTt2BmALpXQyYdrvjRXCnBx
	 nvyZW6SpcLktJVJMwUNIloILHR9vR18yz17wK1SXA+XlKQWYvWCQq/5+MgTUEBabTK+HH
	 hu65GTpKwFHp2KNERxv2TwXaq2v2maoB8yURv2BEHnWpWX4RQdjWMdiyez3jjL3nrFLw4
	 vnvzsDqNCK9epFOfigVjbW8s/L6a0bxaZMas287WuGAH3nOTKq3uaQyus88ZnrnMpW0U7
	 6MZpKj+alod3LDCrGHOMpB6E3PjO3gLjj+xluFAcVB2jDV7TbCXiZVLX6kC+aWblsOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518593;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Content-Transfer-Encoding:
	 From:Mime-Version:Subject:Date:Message-Id:References:Cc:In-Reply-To:
	 To:X-Mailer;
	bh=VdO3TkGJkE0/5auvzRmeM+H+7fXA7G0lgo2mz/y/Xz4=;
	b=QLP/bK31LEtGvYhjp8MV8N6SNi6UTYn8NZx/9re6fn2zXj/eMGQulnB4Bj+6gM9eV48M
	 Zb+MeIvzQNkz0eqaJXXUcgAnDDd2jFoDVGXOT/s1bSpCbrBoEuiTvdI5Oh9uU9MOI2NXt
	 +u1/Kh3GAsTy886fpj9l1iGcSk7ons/2l23kMl77wOC6yUsOA7wzcSISMnF587K9mPyIV
	 uq+OIdQVaKHfhK5UjEo/2+QwqJzr5gW4/TuIRYaGeVRx1mVGFHU7FtQPxco87olckoCon
	 Jd2cbMUVgtDu+5afGlne+3ZAE+sGph05E9sYL18/5FvxeIuoME3deuFaKgFYXv0Ty5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.174
Received: from mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73DE606A31D
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 17:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D73DE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VdO3TkGJkE0/5auvzRmeM+H+7fXA7G0lgo2mz/y/Xz4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792518584; v=1; x=1793123384;
 b=h4OORfT9rWFowZj64HMyMOZAt72+Zr7NSmcIe6phUUmHr3wiWCfvZSwNw0mNLtUckfgoAFe0
 KDd5NCY8NwojYnunHfmL1PB89EStXIb5yvBwvnVUJYsH0IJ7iVrjXpDkEMsXKQm1PZcT9PfT+Xq
 F4WbgEtI/wpTusrAD3LXsZNY=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 27681babf8702918;
	Tue, 20 Oct 2026 17:49:44 +0000
X-Mizu-Trace-ID: 27681babf8702918
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [REGRESSION] intel-iommu/brcmfmac DMAR fault on Broadcom PCIe wifi, v7.3-rc7 -> v7.3 final -- candidate mechanism and proposed fix path
Date: Tue, 20 Oct 2026 23:19:29 +0530
Message-Id: <BCAFF55F-7FFA-4CB5-8738-F56D0F205086@linux.dev>
References: <1a15a4b49f0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Cc: Jason Perlow <jperlow@gmail.com>, baolu.lu@linux.intel.com,
 dwmw2@infradead.org, iommu@lists.linux.dev, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 regressions@leemhuis.info
In-Reply-To: <1a15a4b49f0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: iPad Mail (24A446)



> On 20 Oct 2026, at 10:40=E2=80=AFPM, Arend van Spriel <arend.vanspriel@bro=
adcom.com> wrote:
>=20
> =EF=BB=BFOp 20 oktober 2026 18:02:30 schreef Jason Perlow <jperlow@gmail.c=
om>:
>=20
>> NOTE: an earlier report on this bug from us bounced off one of these list=
s due to HTML/multipart formatting from the mail client used -- apologies, s=
witching clients. This mail includes the full original report plus a follow-=
up, merged into one self-contained report since the original never reached a=
nyone.
>>=20
>> =3D=3D=3D ORIGINAL REPORT =3D=3D=3D
>>=20
>> Hardware: Intel CoffeeLake-H platforms, various. The affected device is a=
 Broadcom BCM4364 802.11ac PCIe wifi adapter (14e4:4464) at 0000:05:00.0 on a=
n Apple MacBookPro16,1 (T2 Mac). Aditya, including you directly since this i=
s T2 hardware; copying iommu/pci/wireless because the fault signature and th=
e fact that it reproduces on only one of five tested machines (at the time o=
f the original report -- see follow-up below, that has since changed) looked=
 like it needed eyes on the core IOMMU/PCI path, not the driver.
>=20
> [...]
>=20
>> THE ONE ANOMALY WE CAN'T YET EXPLAIN
>>=20
>> Despite the last two items above being unchanged, the actual generated .c=
onfig has CONFIG_INTEL_IOMMU_DEFAULT_ON unset after make olddefconfig agains=
t the rc7 source tree, but =3Dy after the same process against the final sou=
rce tree, even though our template explicitly answers "# CONFIG_INTEL_IOMMU_=
DEFAULT_ON is not set" in both cases. Our working theory is that some other s=
ymbol started selecting/implying INTEL_IOMMU_DEFAULT_ON between rc7 and fina=
l -- which would override an explicitly-seeded "not set" answer during oldde=
fconfig resolution -- but we have not identified which one yet.

intel_iommu=3Doff has the same effect as disabling this in the kernel config=
. The real question is WiFi was still working before when intel_iommu was on=
.

I wonder if PCs with Broadcom chips are also getting affected since we have a=
 confirmed report of a non T2 Mac as well.
