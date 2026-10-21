Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.68.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549426;
	b=x4RQSWzJ6rFN2Bn7s3lB4U8pO9GKI8hAX8/wrFFFCo8Q6UQZ9qJCniQdNU38FkhB0vu2
	 0IpgRjOyYJA5XOlP+239csJdEG07hXiS89cml82TkBU3uxE3sLc69W8sNlkff/vBFw1p+
	 ISv/UNPWZ59E/i/aVZu+ZKLl5PXKkYUKoQrgC/1eV8clqAvhwfOrGjW6nlHSb1X7rvPLb
	 pgwi1xCr50UqFEH/Z0R7SoBCGtViOuLpRy55HGlqnCDqfczdLuaVwQLTUco9LhqcYIw7e
	 XVdU47dZ2SQ5eHLUcsIJoWDh08LHeGqSianw5dZ7zjV+xhMp3PVRisORKBNpkITwoLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549426;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Authority-Info-Out:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-JNJ;
	bh=GDEvEH/LpDgW+uEZTtQvjnKzJSBloxmBvXK14a5S0Ac=;
	b=wNRfLtX3/SZv52HsuSBj52KnhtCMvRtDanCZSpStdSuuibLk+6nyIkDrE/smgQAamV5d
	 +ZsQZon2xo4aXO+YMOKSse/qfgSHM5XKTHolDRTWQOV9tVBD6EWmND3EJKX/zvPX52Ba/
	 zueDKTBYEN6hvSolWiLuaH9JXtuNKrVAYpWpSwS0JW1CdztsV2G+Me8KV3pCF2bQ57VFG
	 dTdcuxoqV4q1WbduhKiIKoiQ9+xdkeShZlF5eZCj9r/kwe3pquM9uS0RajXILXCDh4JwW
	 nhIRmRT0b6gbisiQTLdv5Un90eKVPguZW+waTdoCnUYtPPUg8bifYMzlzi8G0Un+ZGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icloud.com;
	spf=pass smtp.mailfrom=icloud.com;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=GjkpDHWw;
	arc=none smtp.remote-ip=57.103.68.93
Received: from outbound.mr.icloud.com (mr-2001g-snip4-11.eps.apple.com [57.103.68.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79593606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 02:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79593606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=GjkpDHWw
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPS id 5D5ED180021A;
	Wed, 21 Oct 2026 02:23:44 +0000 (UTC)
X-ICL-RepId: 01a15c45-8caf-71fc-bdd1-eab4e7043f60
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQFIHV8EWxxCDFYCVARLVxQEHVcaVhlWHVgUWgYOXnIZWhRcGFNFUR9UWFUJCgJRHFYNV0NUBF9QSxsOXAdLWhVVFw4CQh9QH0wWV0NaGRwZWhRcGFNFUR9UWEMZRVZpQQtPHV0ZWxxCZFhXCQoCURxWDVdDVARfUFQRV1ALCAcVXEFSXgMIBBIOHAAOVlIERQpAUFRUCABJCExRWwdYUEBdG1ZaUkVREVQdXy1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1792549425; x=1824085425; bh=GDEvEH/LpDgW+uEZTtQvjnKzJSBloxmBvXK14a5S0Ac=; h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version:x-icloud-hme; b=GjkpDHWwttT2jlIm7qBUWY8arF1mLlTQA4BZaJWjhvYb4ycJXDXaOY/x9BW1ilsPAODhzCkWt5efThIivkPrTUm1A9YgmzAp3luuz1XbJQk3vnpDitMoIA1xWYjpCnbvCNoaLVqzNeCw5+w/m/ixpvDWn4hVwwV0aCuRFaqolDZQMlCd43znSfheFJ5jdU6ErCeD73RZmRMU9CH3zaVCuQtWxNCAY6yisjAIP+hhN6NjvDoY9jeFVj/dklZK+DICRrDuf/XV28Mwusi/oNrydFHIT1fVf/zhVj7/Pi22rHwvq34ycyGITMj+MWn68bPIeEDVBKk+PNprwpdOItjGrw==
Received: from archlinux.lan (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPSA id 86FA71800156;
	Wed, 21 Oct 2026 02:23:40 +0000 (UTC)
Message-ID: <c5ee9a34c6b7d3ca96538c9cc2914b603b0dce7e.camel@icloud.com>
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
From: Edward Malik <edwardmalik95@icloud.com>
To: Andreas Wild <andiwild@gmail.com>, Thorsten Leemhuis
	 <regressions@leemhuis.info>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Bjorn Helgaas
 <helgaas@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, M M <restafvalendergelijke@outlook.com>, blaat
 windows <blaaaat@hotmail.com>
Date: Wed, 21 Oct 2026 05:23:36 +0300
In-Reply-To: <20260929080109.53944-1-andiwild@gmail.com>
References: <20260801201244.4421-1-andiwild@gmail.com>
					 <20260917233355.GA1115024@bhelgaas>
					 <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
					 <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
					 <1b2cceea-8da4-4239-a955-e0c6b475a227@leemhuis.info>
					 <87c93553-d74d-4588-bd54-0ccb2728f327@leemhuis.info>
					 <20260929080109.53944-1-andiwild@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Authority-Info-Out: v=2.4 cv=JKA2csKb c=1 sm=1 tr=0 ts=6ad82231
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=U1xsJXor1XMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mehdgkVfAAAA:8 a=C7AHVqOwGFqPf_5PTdYA:9 a=QEXdDO2ut3YA:10
 a=J1pP9gvGZaT0y92QayzM:22
X-Proofpoint-ORIG-GUID: ly087XXSoiCvN1Z6YN0Q7_sC23W1ZVB2
X-Proofpoint-GUID: ly087XXSoiCvN1Z6YN0Q7_sC23W1ZVB2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwOSBTYWx0ZWRfX/OX3fDKX97y5
 44TIJwwjPzcRlMkK4CBaZDE9DPiuhPc0YHK/WjcxU3eWgBqdyYzACzSw6rFCS0k11+ylVd+CHUL
 sInsCER+pvZ4ATJ2bNI6LODE9KlsE6I7DtHqwYjyMncvhmiS8BjAzzFnbF//UvijJiqJDIhj/J9
 2UEYi9LuZbW2ddSuhW9yce4D/Jd+ZySssAc/qOKiWmLzFD1ldNj3xou9BvnssmV7D98SyeCim0N
 3CxtPZoFlIoflRb9w2cWSdH7bD3DBZVdncBOtX5V+9sxX7+0e1GGeR6bwUMIbZzrfFoZ8yJzEbs
 sWjmZve3HVDJYZkCTYzmoSRK0MHZuyRj1dwVrZnai8CnjdyOmoZsKIQEXGYIqQ=
X-JNJ: AAAAAAAB8KyJNs4iC1Kxd9rxaP+vp32isD0RYSwRSDzlJX86FEaqfULtLlXEDTf6cUMllsvH2dzYHaSnsOazIyPJrOYSC4NGKd5urWYuSWtgxnTonOlyH0HpQ0gCBqp8hzPskxMhoZOTjOrfHv0gOiwWpiedOVNf/OuMlzMHrKaC6sxVoNxsOSUKg0AlKb/udB7TL4EcxlfBXE/BPYYT7JpMhqMYbyPLbOYLq+hXDtfyYsmsu8e26RT7G0WyIxpbVShMR8Zj27UXD0J4rJcIlO1bYUZKn29dy7oM4/1+UGdJb+Z0xZj6q/6s5p79wk26sRDn1PlORyEWJR8RdNzV256QkQ0ePLH+xRlnuQKETRIe7x7Xzg9RKvK/rw8S0gtrr/juSpCV1jd00IUYoPo89IGQXtmtAdJbhxMfPonYweZGgyDNd8+/fQmuqRSldFMmC9OiF/tHeZKVzMbOmDEM3fnztHHfKkP3DssKTIdtMlkbOOW74iFYibX/Gg+HyjVsSncdkzXMltO9QJLLRnkxeX0n1M5Wp+RL1TtHU/SpjRE2AzXKRgiTXeZq9hYwltf/6qcj5Gmw5i69ftnZ0KqBF8hSf5JAl1lWo/dmdKtJUl5uAh1TqlX6UKTovOpNTW/U17u7CdKTZiU6XMjPM+hQSGNlgja+M8LYr7qTFT29MYckLWjGPIDK3AN7pxbWKyaa+kt5iIO2BAAf21UUUos16qDHdm2YhuDHLXVhf9hsiEjOzhoIDr0D4XPQgb4l3Lo7BSUBJIl93hgWxzstrZtZm7W4ncOO5k8PoSWnx5tqguAD++wnS1Czjw2YCtm9F/cz38RWb/C6oKd9LIHoI5gj4y+SHCPGnidNlMe89p2h4jCYx28Z9VL76Tt+zAhS8DU8Ay1t20BJdN/kbVQRPqGiEBg6b3SHgebIfG2plQ8TK50Ujcexlg7ZjRfMTfQ5CagLr03wQ6P0vv7VqBJid8tMR2qVNCZTGQ8
 SPzcSN2JMPm+mjfuiUnVSOaeR4eOKDwkMDoDYakQvWDgGPlC2uXRfMkwgH8uYWGmaMpAEZnnpOI+RtVTpp3jiplbU8sITOzJr9gXaEwkgjsmg69skvfikzNd6LT/pd6c+ePfB702JjznWfmoU2XF9Dq3NmmSqDLpTaPtnCq1LSlfNw2MDwRA6CsGy1kIyA154O9kRJ9j0+0rn1ylisyfDpwTlir3wHazjKhlBCYIEIfx1UB4dmDO4dHjvnjqMta+/A5mq/MC5YTjeABczn1GLUxzlrjL3gKPh0uGFZIADtyXYecLcRGQ+Yhr8+G9jyzlTF2v7wKUdOHp+

I noticed another reported incident on the CachyOS Discord server:
[1.278083] pci 0000:00:1c.0: retraining failed
System information:=E2=80=A8https://paste.cachyos.org/p/35d9bd0.log
I'm sharing this in case it helps with investigating the PCIe
retraining regression maybe there is a common denominator among the
hardware=20

Probably will see more now that ubuntu has moved to the new kernel i
think
