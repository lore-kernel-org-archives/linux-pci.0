Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058B3F2112;
	Mon, 18 May 2026 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105705; cv=none; b=HxAIHridfA1Lmoxk5zQguJKvgnelTxNGY2TOlxLEJJ/Pnjo0h0cC9xHbEKdVvlM9JUnE+xlVVu131tIROWf+9jzzFUhpBjO1tyJVxVVEsN84TKL5dMk3H2c9lOw9e7jAvSeY95hZEwKX1FU3dXySTn2RFpEeQmL0B7Ffb+J6NGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105705; c=relaxed/simple;
	bh=GIFH4H+Ftyh+BSQrEtzdmYTasySDCxriNi2nKRqemzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKHwvFQKOUFbUU6NVGcGDtVvjQGjSkPwokFT4D++STx3TNwZNPsmCiMVGZKoaAwb9cokULAl9WdegjYLMSY++hGqBfwm2184nCtjj2V++dvOZ+D8p5y9/HK9HkOBugW2LdI/36/2POfhe1tajsEjnnaRw6LZNmWyWUt+E6sC+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=njJP1rZ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="njJP1rZ2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I4pAvi223129;
	Mon, 18 May 2026 12:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e+NfyD
	LuumrWjIJ8nZ18sLy1cetj/M6SWZHlBf6Drw0=; b=njJP1rZ2c2v3NtdTLLqYNf
	p8KnGsEdfcJtg7vaHYrYpjnokq0810Y07MhfMD/o23aP+nBA8OOOtIPfMFCxztQa
	cPIo7O2ATzfpCYiuHdAoKmbs3/QITYDZOtpEBZ4VC19hjhzcvPA3FnZgRC9T00w1
	jT2FqvyzcpZTQNmrG9T9n2Jff+byWnU6n79fSEJLswDbghFj4cXE9jRNQYG5F1Pu
	8xL8uOc40JnAL7FksWJ8nWeTL9kleaPsrAPA8JRxhwU2FZoaTJGA9WRrKscGhyL4
	togDWrXt73xzbLtZzEeN6MfWsPvsESrsEbhyi0VWpkTOeXdPJaLo5O8gWBrbXFzQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h887dcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:01:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IBs6BJ000761;
	Mon, 18 May 2026 12:01:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vnunf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:01:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IC128P22544812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 12:01:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 723802004F;
	Mon, 18 May 2026 12:01:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DB6E2004E;
	Mon, 18 May 2026 12:01:02 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 12:01:02 +0000 (GMT)
Message-ID: <c0619e4edfa06764bcbd0ab759f0dd03e3d21041.camel@linux.ibm.com>
Subject: Re: [PATCH 4/5] x86/pci: Use official API to iterate over PCI buses
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Richard Henderson	
 <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Madhavan Srinivasan	 <maddy@linux.ibm.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin	 <npiggin@gmail.com>,
        "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>,
        Borislav Petkov	 <bp@alien8.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"	
 <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        Gerd Bayer
	 <gbayer@linux.ibm.com>
Date: Mon, 18 May 2026 14:01:01 +0200
In-Reply-To: <553c703f-ba9c-4785-91ba-2cf62ceb9653@intel.com>
References: <20260515-priv_root_buses-v1-0-f8e393c57390@linux.ibm.com>
	 <20260515-priv_root_buses-v1-4-f8e393c57390@linux.ibm.com>
	 <553c703f-ba9c-4785-91ba-2cf62ceb9653@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QFZHyjzOvy-Azmh1oH1xaLzVGu-OSuD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExMiBTYWx0ZWRfXzuNcKh95vCxd
 geQ08wF4Un+p2fnxHLsnhgPUBABNVbMhhVCu73sej8lMYh8RWdrbhgMQebWKVfaHnkhz1LAc+aA
 Wsdy9Q+6XvBmaOIKDmZ1XbODr04OApHMW6yxApQqLrMEMAaZ2zdeZaw2Osk2WtjnqRhNtMXy+Md
 WIG3xo9+bYLjSW/74ydiwbpbWanMqcbkh4rW+P1iWEG49h6VoFoAnR6WWh8XWNj32/ezq6aXKQB
 tLuymqkb2ee1QqFT+dGxPdReJ/Em4/ZOLindDY94N/F5vk1/QH/tghR+SuLQIl1wC4CarqW7KEA
 bsywluft/Wt8VcC91NHDXDkKayHfSnipG8PUSan6nv5otfjzej3mZHvpF7+hRUhWi2C5vR/ZNhN
 W+jjgO/lVPIUzgD4kMLQG2RvJKPjq3gtrCcUg9mzwucqg7K0ieqvsbj86MNnELg2PzQmlbgztUX
 g8ZCup7yUZfilLlWtAw==
X-Proofpoint-GUID: kcV6MLuFtMArK-fCd0goVCjhbn9bE92K
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0aff83 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=K1lEL3VxD7dyB7CPxK4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180112

On Fri, 2026-05-15 at 08:13 -0700, Dave Hansen wrote:
> On 5/15/26 07:22, Gerd Bayer wrote:
> >  static int __init pcibios_assign_resources(void)
> >  {
> > -	struct pci_bus *bus;
> > +	struct pci_bus *bus =3D NULL;
> > =20
> >  	if (!(pci_probe & PCI_ASSIGN_ROMS))
> > -		list_for_each_entry(bus, &pci_root_buses, node)
> > +		while ((bus =3D pci_find_next_bus(bus)) !=3D NULL)
> >  			pcibios_allocate_rom_resources(bus);
>=20
> What's with the 'bus =3D NULL'? I thought there was some crazy macro magi=
c
> going on or something, but pci_find_next_bus() looks like a normal
> function that's just taking a pointer and not _modifying_ the pointer val=
ue.

Initializing 'bus =3D NULL" makes sure, that pci_find_next_bus() starts
at the list head; list_for_each_entry() did that implicitly. I didn't
want to rely on implicit zero-init for local var's on all the various
architectures. But I'm fine to drop it here, if you prefer.

>=20
> Also, wouldn't this be a more readable way of writing what you have?
>=20
> 	while (bus =3D pci_find_next_bus(bus))

Yeah, another occasion of me being (overly?) verbose.
arch/sparc/kernel/pci.c was my blueprint. Again, something that I'm ok
to drop.

>=20
> For that matter isn't the kernel idiom for these things:
>=20
> 	for_each_pci_bus(bus) {
> 		// do bus stuff
> 	}
>=20
> I'm kinda surprised there isn't one of those already.

Just guessing: There was too little use of pci_find_next_bus() to
warrant that short-cut. But I can make a proposal in the next
iteration.

Thanks,
Gerd
