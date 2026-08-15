Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C22F8EAC
	for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786771811; cv=pass; b=HXCy4GO/RUbcPlK855GwdPqlTZNeXoOaZDhhRdnY/NnA28dfIhwYZYpkWeeedsZLJ+3jfsfazOP7pKB2/Z9CeWFczpJ0Bd2lsiDWi9YygbPAFDfW4Wc00vfRpSDlTUYDUgnAG+meVJBYFf02DEGGBcRc0YGOL3nrkN2V3ii0ANw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786771811; c=relaxed/simple;
	bh=MsmsXWLLqYeSfDtEeejbdR9MAUqzNTm76HAYa63Vzg4=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rjDHjxfFuSQ3C+H5NK3oKYvTo6hR0M7S13onSK75QH/83N798L2t3N81Z6I3wKMSxQNShhAlD8YrAUE+gDTj+lIoCCQMstyqa/BLcMIS5ve5M16ROxFVkGfHNqrC50VT6/lKLnxk0b1riVXDl9oTjZzDWJf46vlA3FXwDmN9uHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyzBzPkG; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyzBzPkG"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c8e2e39easo17274251cf.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 22:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786771809; cv=none;
        d=google.com; s=arc-20260327;
        b=DY8W9vnFOBEBeXJerHiraQJPbrIJiAnYlaCLaZ9qOE3kXyq3keKysgN/oeD09e/sde
         28jXU9pcS+hg6HCfq4lQBZb8n0mCaFHh11heoePEIlQcDjSOUFirle/ROvcyAMMelZhG
         a0SVycucqsunNYTpgPI0fGn18SfXMzc6LQfU5zRSPcE4nDMjvo9zT0AGc8A9prLmvpax
         ap+g9SeGkhdKKfBi5/iOWYUj5NdgbuhbIZuTfOBnMsoXNucrHGyAOuAEALOluGEuvqLa
         f82GycRMb/Ohq7UURZC6sDs+Y3Me+SBPHRby3qJ4yVMwSjdnJMDRU/nJw6Onpf7AexAA
         Lb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=MsmsXWLLqYeSfDtEeejbdR9MAUqzNTm76HAYa63Vzg4=;
        fh=EfujMstWYmdFvPeCBAhLBiPi7yWFoNM15oJi8Rh/J0k=;
        b=RR0eHO3UQydVRTcPsissqKVQUBNklmHYtjgVJUGaRP+g73coj2vOcS6t0RzKWWarTo
         RoSG9IDK3Odk7WKZEh2Ohsj1axc0vU8wbqm03aTJsBnZwlBWazFwpK6SrqoP3U3KT/95
         upLxptDEaj3n9qXfBkS5e9cE6P1TwknP/4+v5B4AJjYD+yYAryyg0zVAeblDL1jHH0wt
         003lqbTKuVHYnxYrxf2AOz3gFSqPc/3nao88gKNKmX7Vx7NTgnYgzWd2+INTJlPCXYTs
         be7MSDHn3fV3Zho/L4cQ8YsMN7RP6ALc4fdARoVerD54n65XNN0cSHUaRJ6ZEs8nf0L5
         MYBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786771809; x=1787376609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsmsXWLLqYeSfDtEeejbdR9MAUqzNTm76HAYa63Vzg4=;
        b=TyzBzPkGYDcpSQ3yXn4zLnWRVTptzymMOqcuoav3Xn67sUDPQYJA4mBSRjTyPkAjEG
         UviTy/D0eeXJWU1fWxLcfIb5GXprwC91k1YQ1JdeDpuo9xp3Da+3v38qORx+4TW7UfwF
         df1w0RXCcIlYBETnwNhdwDjWh1duksK3Z2imxM0dlzb73mw4AJrvygRkL3wQthdyWtTN
         GBZuhLcR/oWE2xOxKig87QZWGwtcNURx8kwgay9UG0WUZ/O59PhQlTQH8w/otC5x6etS
         mFxmAT0z1nmS/SMQBLyOLw97e/hVs29pqQLtN0ypHqF1bLNQjeu27TpG71i1WkiIL8mN
         mdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786771809; x=1787376609;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:references:in-reply-to:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MsmsXWLLqYeSfDtEeejbdR9MAUqzNTm76HAYa63Vzg4=;
        b=f7xe7GnJ/pQ1uMhVkavdLt4tZ/L5ot5RWwD7kg6xGbJDylNtxyf/jyQJUt+9hVcZAq
         yCmtcPV69KzXZU9dVZ9d7qaQ2JtDHKOVkOFyulYrlaNs7e5BLx9kCQ5ed6Sn+5tHw7+n
         nh/QpzIZh69/+6YcDH6TlcQ8zY6wwoN3oymkYlgOADrBn5jeuWbPqEjGAKI5gz27j4Lb
         tijGBG3ilE6UQaNVDT14MQX+xy5mvw+YqPv70LRz2n3Lqkgwtwgvu3QDFPNHiUNAkZEH
         mgnprbelgTHH4vFKWi6GISc3rTjZbW4RCDEc2gweVl4Ufkpn0Vy/017YXJhE4YMEW0kk
         cveQ==
X-Gm-Message-State: AOJu0YxPmVl3D+LX+U7oZyTz4m5EYK2DYSVNFN+0+XmSoW8DntAq4KJx
	a3hVK2JB5K1BNVPKbx5OZOFpnKXJf1HHt5U+tgDib5fj4ZKog7TWKyWe4PrJ/RQy7azC+FPmRjl
	MVOL1CoPyLHxLHv5C9eirfKEoWx3JAjuWt4YD
X-Gm-Gg: AR+sD12yLzyhL7K1ZmtSC8hvLEzYDeEW29pAowc39beTy7g876+JgVm2VXmAFSXUFch
	9GJPWc5Ky/mZ/Pd8uvPROrZiLsCGh1cacHFMczd4GS315Lsr57Eg0q2OK4CTpH92RNrdgNum1qW
	LRzEnB+chVPqjZ9bdlJ5LMO434nFlvEyPJn/uRbKpNEe/sVfkgIROJTNNLZkzo82ObAYHVDBf48
	+EPoJqnMSa2pwGh8ncVBQf3Atj64L2LfM7skwO97XAHTIseVtNvwPDt6oZqryaG0tNoAPnWEpwb
	BqyqWRZQPGaJ1usa7v8MmMJRF1GXm+2hkLSKT1wzaVjbjJzXJ1Xc51ICVLzY7Tjb0IzbHPBx
X-Received: by 2002:a05:622a:409:b0:52d:844c:b176 with SMTP id
 d75a77b69052e-52d853c9846mr113644261cf.11.1786771809030; Fri, 14 Aug 2026
 22:30:09 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 22:30:08 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 22:30:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPbDjBakdW2DdVoegF94Hk8w83oh4X1nCF8brQ7H8S1UZJwbng@mail.gmail.com>
References: <CAPbDjBakdW2DdVoegF94Hk8w83oh4X1nCF8brQ7H8S1UZJwbng@mail.gmail.com>
From: ego RRR <egorkara@gmail.com>
Date: Fri, 14 Aug 2026 22:30:08 -0700
X-Gm-Features: AcwNN1WqFFdCYX7vm1pe6E4fHdnZHjgLoc7iUeotJOmLHmaL2LK7BJTe5YA-u4A
Message-ID: <CAPbDjBYq51i7Nie7cn=eUPQ8+5hy+Oq9NmbgGRFFMAnLs_eoQA@mail.gmail.com>
Subject: Re: [PCI] AMD RX780/RD790 root port and RX 6600 upstream bridge train
 at Gen2 x2; RX 570 reaches Gen2 x8 in the same slot
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

A brief follow-up on this reproducible link-width issue:

The RX 6600 consistently trains the external 00:02.0 [1002:5978] <->
01:00.0 [1002:1478] link at Gen2 x2, including before amdgpu
initialization. The RX 570 trains at Gen2 x8 in the same motherboard,
slot, and Linux 6.18.38 environment. Retraining, Gen1-to-Gen2 cycling,
Secondary Bus Reset, and early-kernel retraining did not change the RX
6600 result.

Is this RX780/RD790 [1002:5978] <-> AMD [1002:1478] pairing affected
by any known interoperability erratum or suitable upstream PCI quirk?

Which specific read-only config-space data or kernel trace would best
distinguish a link-training compatibility failure from an electrical
failure of lanes 2=E2=80=937?

Thank you.
