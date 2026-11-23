Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458581;
	b=BoTnvRtYrBPEpqRWD9tbiVFOJyt0UW7F+UX00AmOE7uthJgaqAezhLsvAche9OChX+r2
	 BkcV/mHSsXVRguRuAZF1++ifb+eo4RF1xhSVj0awmx7iRya2WOtOe/YWjcwNgV8gpJZFm
	 zJdf5Ih7hg500tDbLwj8kC33IHTZ5V3YUpDkrikvb2U+KnqK7TPcuuCs8/cNtEHn5C5o+
	 ybZhc4ReZVbry90FP9kfLXXBw9DF3paIVUfy9BuToFTjao42vaWOLA+HqwW3XlT22BJ3M
	 Xl2JgHIMpPf2ucZoGaMwBklbKxdbCojGx4s+FlZoSPACJGuEUNRKTKVvbiRPigjwkLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458581;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=/7EBtZ3ZhYiV3N0p/c5cCwDwkFdY7/hSi3pC7nQcOCI=;
	b=WJ840/BP9xiKsY3VCudHMJx1v11qScGiqpe30znCJiDAeIar3zJV17+wrd4zsfJSec8o
	 cFNLRAI//h8+pj1DRrQnXJyFN2VUcSFIX66v6iyzxZPlrqxaFPlxG05PJ+P5f9dQkyf24
	 ceze6zGtaESRDl5+wPBGoJJ6nvh3fwVgTSwSCicPiEVpdS52TEm95j/Aor59l1utMko4j
	 9nZrZLMkEiY1ga+AiiHjy5RtN5DVvfhlC1d558cywufsJ/jy2Br/4RSAymCksB/siG1hP
	 1NMjHFYQiPPQF/0MpFuKHoARsCW7QzAY9uqL6KEvfvbvO0razoU6/HFTF5TRIHN8Jxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=oTE+WejT;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905A606A683
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 18:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C905A606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=oTE+WejT
DKIM2-Signature:  i=1; m=1; t=1795458578;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:Qpw+aOkwrV9Xj92VWMfAauHc6Oqs
   1Vx1Oquv5Fqin9RSzD/o9nAuKfOFqz42X8UJ0h5Jv7ZF4qsCFOh1/nUWWk49jYKzLF+MhHm9Qpj
   FESyxLH8Ue36dHquzIsBRYtqJPZyrSH7r3nq3k/xKXJPwLnkSM/mpTrPgYcRjdxQQdN4QyoP/dh
   mwgV3lcHRNkNvrCG6GExfpTYGap9Y1Jy1mxh4K26kQico/4hVgjcARSig0xMORWmjjhfIfDWD2K
   s1TOTE1asUp/fXLqQeze0/uj/TZsjs8pICQFmr6i9mrjM5sZeDNwTIx6xlrSY54qmOCV75TF0Ml
   27aC6XN8Lr22/g==;
Message-Instance:  m=1;
 h=sha256:
   xpTSHVp+eMBaHm+tYFOMxDwmuNBiJPF6e3oJb2WvS0U=:
   McPPzdxviAIqfRgFu/IbKp2UInt39WCQSS5tHQPTT7Y=,
  sha512:
   ZZ9PPYG/TMBgE3bBrDp4YHjjWYgbeYCmqEs6bgtbkBLFN4Ai4OzLOXqjUU2OE2LEN4WC5UtPV9lt3cywYLSGKg==:
   uXNSa3QlsZS2OlqhMgwSYedlM6yDmIsQcxY3KVxoOQsaJEN2E3NnGSHOUlfdXll9oHxSqrM4TT0I3fxpIDbOSg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795458500; x=1796063300; i=markus.elfring@web.de;
	bh=/7EBtZ3ZhYiV3N0p/c5cCwDwkFdY7/hSi3pC7nQcOCI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oTE+WejThE04hFoTzclzZX2BxhxuE1CsVjdnIvpWIdlsoAqNmKxGR0GQOo1fYKEe
	 768ypc4DZuPJRwJhHQ2iJ71M66yrf14eLeE6NMtmUofXhmk5KHhocagGIOy9/gYZ3
	 is1ef22WNDyxVBXmGhmylnSuQB021ZCETPM2yVuoEXf5G99AE2/0i1wpoX2m+fvi3
	 1cwPAfUSNEyhcuMk4s6PgVOuTKRIPzECE+6DZbQvS8oeCh45XeKFyL5CdujmEt2zj
	 jm2GJHa8KjL24yfjqBAA0o7vSQNhQI/utI4EmyBB39DmPGCw3HVXLX32lZnBKj0sb
	 qJ2b8Wwm8IZkcaX8ZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xrs-1xWfEm1fxc-00DhEm; Mon, 23
 Nov 2026 19:28:20 +0100
Message-ID: <996eeda4-c363-406b-988a-a2ee6262f04b@web.de>
Date: Mon, 23 Nov 2026 19:28:17 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI: xilinx-nwl: Use devm_clk_get_enabled() in nwl_pcie_probe()
To: Frank Li <Frank.li@oss.nxp.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Florian Fainelli <f.fainelli@gmail.com>, Frank Li <Frank.Li@kernel.org>
References: <f691bbaa-ddb5-45bf-8f85-fcf354a6af03@web.de>
 <awR8rehnxAE3SNFh@SMW015318>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <awR8rehnxAE3SNFh@SMW015318>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ULkA1SX0Bji2GQMEaoYexBAynTCg7+tZWjSYvaW++MwYx/7xC6G
 SN2CZu0MSbNk39gSdzwpezyot01eLX+XR8Q+eaeHYOua20FG/ZVcEH/ZpfUbOOPwefwGVgH
 8TOL3Ezs4FVOd+xkBXYQ75r1kzLmuJnUqgEWkhos4ASCx7HMDktm9t5w3x76Gdc62JxsQMY
 IkTCY0/j1oAAeWBaRY0PA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NcbT3qHiMxA=;2c09klyQMaYSH87qYz+YhTAu350
 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
 eZMOQUZ7+H1EJpL6C+2w==

>> * Reuse existing functionality from devm_clk_get_enabled() instead of
>>   keeping duplicate source code.
>>
>> * Omit a clk_disable_unprepare() call on an error handling path
>>   and in the implementation of the function =E2=80=9Cnwl_pcie_remove=E2=
=80=9D.
>>
>> * Delete the label =E2=80=9Cerr_clk=E2=80=9D.
>=20
> Needn't * in this case. Not title ahead of a list at body.
Which wording variation would you prefer finally?

Regards,
Markus
