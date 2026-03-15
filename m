Received: from outbound.ci.icloud.com (ci-2001f-snip4-11.eps.apple.com [57.103.91.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2426FDBF
	for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773574572; cv=none; b=bpWqMOf4QRzMiZyQdoPc1MG0zxCmJSYLjTKPwjvZZ4JIDb3yhJdFTh3Wjs0VF0roYxwXT1Br05cpNP1uchFiyRvHSj8iByhRRbgsLkk4KmGQwqz6DIdifnSaJvzqdtOdr/z3L/76z5aPmWreCvHg6mFhf4yFkkT+M8NrFzBMKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773574572; c=relaxed/simple;
	bh=csoKdMzy75KMqDF2q3v5t3En7nzpatuYGBdUHbktvg4=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=IOMcleRyHuls7q0+zaaah0PY4gwJo04JR9Ir7nfubKINwGSKg7xUx+mFWZKXhZo5hThdlLB2Dmxx8CTZ0qdC1zkV/nvs2yMSluCtu7AbpV7sTzJQGogpqGknImO8/KvkS7QCOghnY8pqewXxYA6W3bXQLRMnBEwv0E9nJXhGHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=m++aHEsL; arc=none smtp.client-ip=57.103.91.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="m++aHEsL"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-5 (Postfix) with ESMTPS id E7C31180030B;
	Sun, 15 Mar 2026 11:36:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1773574569; x=1776166569; bh=qagBSxTalG+mGFSVEGFBTaku7e5MtPGxHcs2hzFndvI=; h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme; b=m++aHEsLnXNNJnPyyLAwKHo6cQ7ir9dAuEymQf26SyoEcyPa94Sy7iTXK7ST7Cjf8C8zFOMt85K6FjrnC1AlfS8CGV9dYPMzWtskiWX1ANQV+54MdXO2zm3pck0NEoiJwdk3vzb1QPZVT1YdGhzPB+zYVRDiZcNPj/La2jhc1ws1E9Q5sWTgRFCjrflZP+bvboDSUIbcK9AACyrUeUnkdDi+ZkRFFjkU1jnFw4jPsgBaP8NkpDQ2Pe8ZeU+TrNglWNmdHxRQo0ph3CoAM2xojLovFeee8z5h9bF+Xf4yBphcNhnc7K4CLO8ZwnnxJgPWI5msmo3JDroAjadDB48QVQ==
Received: from smtpclient.apple (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-5 (Postfix) with ESMTPSA id C1CC018000AA;
	Sun, 15 Mar 2026 11:36:05 +0000 (UTC)
From: =?utf-8?Q?Michal_Babi=C4=8Dka?= <babicka.michal@icloud.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_A7866E0A-6182-4995-9B42-A204F5CFB2CC";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: [BUG] Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window /
 BAR allocation failure prevents NVIDIA and AMD GPUs from initializing 
Message-Id: <8653B042-F73C-46F4-8D3E-79D9F0CC1250@icloud.com>
Date: Sun, 15 Mar 2026 12:35:53 +0100
To: linux-pci@vger.kernel.org,
 linux-thunderbolt@lists.01.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: PLNpV9r-nuk35LhGaVjUA4u93585jwue
X-Proofpoint-ORIG-GUID: PLNpV9r-nuk35LhGaVjUA4u93585jwue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDA5MSBTYWx0ZWRfXwCA0uBPKyiDu
 m2hrnc6xQ7pt1AIGrwcT8PP1lf90N9IYIlGYs80ZhK0Hhd31I+h2Uc3X17JMOZqjWJPDOw7CYq2
 zlzVyzbyVmlx5sX7/4cUz1dP5ksin+/IxKECJvtO4laXP/lbO0t8DEW35P1nQF2TkEPMPQfRTP1
 yjMQCpTSKoE2pPpCFcjbpfuAeCEGtcu8d6NhBc74pCclv6lHpm5Mi2jJUyciWOTzByYId/je9mq
 Noyi+9x1ZfXdSL/ft4JKiKMLmCOtjnde7CkRnYjHKxetbO2jONmPGgDQz2jzUQj6fluADp8u6zn
 4YxKb8kiHfsfSoRNRdABzgVKEErhxOJuzUt0m+9K14MOLtS3w+OuTapgu2QAKw=
X-Authority-Info-Out: v=2.4 cv=BdDVE7t2 c=1 sm=1 tr=0 ts=69b699a8
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=M51BFTxLslgA:10
 a=x7bEGLp0ZPQA:10 a=SbrhuHIHViwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nbtgWTm2519r-fIh0WoA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=YxHn8vszZgrxN1Fj7YgA:9 a=ZVk8-NSrHBgA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603150091
X-JNJ: AAAAAAABru8QV7F0+/DSM14bQrjFTu6aiIuwz7vZjQKCqJxoREJ7gphNk3Xqj8PIoZupjxxUGF4h0yzMfAJXZV8IhzSg3GmOhce4csZFqODHaSt3ZA2aRid9071VQvzUzFkgWhpwEWe3v7vmnxcfcnkUM2u3kxXhGPAP6bucKDM6ZAypmHNdAP0ZNifGBezSoPJ3vcfKjzbzr+kQ0q+v6Fat4Cx5PJsZaDgppd4sJiUFIBbKOB7FArAkpzVv4XxmMu41VzGUZWSNnkXKKltbMiysdn5fwRdRRzALecGwxE5VyBE9Wxl03g4k5yDKOlRsCJw9w/c+qqoj/cEHpYop1rgdiCCbRtX/TF8afPLXNsyVPzhLPKFW1fXJu3d2ug34rwiwp63QU41HS52ZSCjlRGJgB0bTw/Ex2s+mPltk8f3lwbMowpYHtpJwSv7hihYYxkGBKCc31BlKSYqZ2Fk2cjtq7cm2VMhvi/+r8jV5hpPQC1LeWi1iUa+vyFpgVLmmYwlypXJNMJip1+BX4u6kQt0T3iJI8h0z66zi4zD4ObAxn1JYPCGnjg3l1zGTHbxXgQ7j47D4j7I8xQ77lRsWbF+qs3zHbz7BK2HDADW3muK70cZqCOG8DukNZXXqFdjTzky83t9tiUNZKG7h0k6ZQ8IW06Bh97f5d8EQn6LHCezFOF5DYuj11T4HN7upLTdCUl0JIk63d17joxjAN/TdNsxQ06DF3arEOrp7/pou9VSdj8D+MKPpuOXkOztgeN/CxB9Lyo1/TTcoN99EBNQQYKk=


--Apple-Mail=_A7866E0A-6182-4995-9B42-A204F5CFB2CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Subject: Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window / =
BAR allocation failure prevents NVIDIA and AMD GPUs from initializing

Hardware / platform:
- Host: Apple Mac mini 2018
- Connection: Thunderbolt 3
- eGPU enclosure: Razer Core X Chroma
- Tested GPUs:
  - NVIDIA Quadro P400
  - NVIDIA Quadro P4000
  - AMD Radeon Vega 64

Linux distributions / kernels tested:
- Ubuntu-based systems
- Zorin OS 18 Pro
- Multiple kernels tested, including 6.12.x and 6.17.x

Problem summary:
On Apple Mac mini 2018, an external GPU connected through Thunderbolt 3 =
in a Razer Core X Chroma enclosure is detected and enumerates on the PCI =
bus, but GPU initialization fails because PCI bridge windows / BAR =
resources are not assigned correctly.

This is reproducible across different Linux installations and with GPUs =
from different vendors, which strongly suggests a =
platform/topology-level PCIe resource allocation problem rather than a =
bug in one specific GPU driver.

Observed behavior:
- The Thunderbolt enclosure is detected correctly.
- boltctl shows the enclosure as connected / authorized.
- The GPU appears in lspci.
- The kernel loads the vendor driver module.
- GPU initialization then fails.

For NVIDIA, nvidia-smi reports:
  "NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA =
driver."

Relevant NVIDIA kernel messages include:
- "BAR 1 [mem size 0x10000000 64bit pref]: can't assign; no space"
- "BAR 3 [mem size 0x02000000 64bit pref]: can't assign; no space"
- "This PCI I/O region assigned to your NVIDIA device is invalid"
- "BAR1 is 0M @ 0x0"
- "RmInitAdapter failed"
- in some attempts also:
  "fallen off the bus and is not responding to commands"

With NVIDIA Quadro P4000, the same general failure pattern was observed:
- the GPU is detected on the PCI bus,
- the NVIDIA kernel module loads,
- initialization fails,
- and the logs again point to invalid / missing BAR assignments and =
resource allocation problems behind the Thunderbolt PCIe bridge =
hierarchy.

For nouveau, the failure is visible as BAR/resource allocation failure =
as well, for example:
- "bar: one-time init failed, -12"
- "init failed with -12"
- "Device allocation failed: -12"

With AMD Radeon Vega 64 installed in the same enclosure on the same =
host, the same fundamental problem occurs:
- the enclosure is detected,
- the GPU enumerates,
- initialization fails,
- and the overall behavior indicates the same lower-level PCI resource / =
bridge window allocation issue.

This strongly suggests the issue is not NVIDIA-specific.

Thunderbolt state:
boltctl reports the Razer Core X Chroma enclosure as =
connected/authorized correctly, for example:
- type: peripheral
- generation: Thunderbolt 3
- status: authorized
- rx speed: 40 Gb/s
- tx speed: 40 Gb/s

Important conclusion:
Thunderbolt authorization itself appears to work.
PCI enumeration also works.
The failure happens later, at PCI resource assignment / bridge window =
sizing / BAR allocation time.

Key dmesg patterns observed:
- multiple "can't assign; no space" messages for PCI bridges and BARs
- BAR1 / BAR3 of the GPU not assigned
- bridge windows under the Thunderbolt hierarchy not large enough
- reassignment attempts that still leave required windows unassigned or =
invalid
- vendor driver subsequently failing device initialization

Examples of affected topology in logs:
- 0000:00:01.1
- 0000:05:00.0
- 0000:06:01.0
- 0000:0b:00.0
- in other boots, the same problem may appear under a different BDF =
address after Thunderbolt re-enumeration

Representative log excerpts:
- pci 0000:0b:00.0: BAR 1 [mem size 0x10000000 64bit pref]: can't =
assign; no space
- pci 0000:0b:00.0: BAR 3 [mem size 0x02000000 64bit pref]: can't =
assign; no space
- pci 0000:06:01.0: bridge window [mem size 0x10000000]: can't assign; =
no space
- pci 0000:05:00.0: bridge window [mem size 0x20200000]: can't assign; =
no space
- NVRM: BAR1 is 0M @ 0x0
- NVRM: RmInitAdapter failed
- NVRM: The NVIDIA GPU ... has fallen off the bus and is not responding =
to commands
- nouveau ... Device allocation failed: -12

Kernel command line options already tested:
The following boot parameters were tested in various combinations:
- pci=3Drealloc=3Don
- pci=3Dhpbussize=3D0x33,hpmemsize=3D256M,hpiosize=3D2M
- pcie_aspm=3Doff
- pci=3Dnommconf
- pci=3Dnoaer

These mitigations did not resolve the issue.

Why this looks platform/topology specific:
- The same Thunderbolt eGPU enclosure is recognized correctly.
- The same failure pattern appears with NVIDIA Quadro P400, NVIDIA =
Quadro P4000, and AMD Radeon Vega 64.
- The common denominator is Apple Mac mini 2018 + Thunderbolt PCIe =
topology under Linux.
- The failure mode is centered around PCI bridge window sizing / BAR =
placement, not around one vendor-specific driver alone.

Expected behavior:
The Thunderbolt eGPU should receive valid PCI bridge windows and valid =
BAR assignments so that the GPU driver can initialize the device =
successfully.

Actual behavior:
The GPU is visible on the bus, but bridge windows and BAR resources are =
not fully assigned, which leaves the device unusable and prevents the =
driver from completing initialization.

Request:
Please investigate PCI resource allocation / bridge window sizing for =
Thunderbolt eGPU topologies on Apple Mac mini 2018 under Linux, =
especially where large GPU BARs must be assigned behind multiple =
Thunderbolt / PCIe bridges.

Cross-vendor reproducibility on the same enclosure and same host =
strongly suggests that the root cause is in PCIe/Thunderbolt resource =
allocation on this platform rather than in a specific NVIDIA or AMD =
driver.=

--Apple-Mail=_A7866E0A-6182-4995-9B42-A204F5CFB2CC
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCXAw
gglsMIIHVKADAgECAgQBbLKWMA0GCSqGSIb3DQEBCwUAMGkxCzAJBgNVBAYTAkNaMRcwFQYDVQRh
Ew5OVFJDWi00NzExNDk4MzEdMBsGA1UECgwUxIxlc2vDoSBwb8WhdGEsIHMucC4xIjAgBgNVBAMT
GVBvc3RTaWdudW0gUXVhbGlmaWVkIENBIDQwHhcNMjUwNjEyMTY0ODI0WhcNMjgwNzAxMTY0ODI0
WjCBiTELMAkGA1UEBhMCQ1oxKjAoBgNVBAcMIW7DoW0uIFN2b2JvZHkgMy8zLCBNaXJvc2xhdiA2
NzE3MjEYMBYGA1UEAwwPTWljaGFsIEJhYmnEjWthMREwDwYDVQQEDAhCYWJpxI1rYTEPMA0GA1UE
KhMGTWljaGFsMRAwDgYDVQQFEwdQODA2MDk3MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKC
AgEAregZxhPTQJfKOM/2epEANH4CunjPPtGIcNI9qv0B/vFMIZWmi16tun2e7DH3ehuoHz2drdc0
RPoavzj8wTXFFIrCtZC2TMaG9bOFPUC0J9sLBYWaiB6U5ULFHnam93JhyLheffEGCILR9Pp13YuU
JQuH9sUwi6fqQQ5hOQ+ymhMpebYjNk0R1X+DcqqK9g7L0sYXJESMOrHEyG0aMFRQq18+wFMah6wr
j+zf2fLu3uscv23Ia2NpXkucsRCxLAVFwO0BF3Jy5cNi4/tj3dla2CSmPZTyP2s7tTAk9W3HJmax
rF1RPtXwvGe0PGLBxvLBZUOxc+XVbWj/NZgCX52Lnv0gl4U/aid+udky9UkobLVmeo7UscErAUBu
6CeFX8BGFIOFna69V4oSE6X7qU0uEyZ3NKspJljlgYZYJzxVYMcchpU60KxmmXoTldvYOhElbFwa
Gd64gXMAsQ/34vTh9LKjNF5+hs3uda8nK1Lg5/XhVlcq8gH4nvd1BQ5sFzGoX10ZgbJoDm5jqi/q
ufmRgTYzGQa49e6WQJJtU7/zwpxgqnOfbYc3YVSIv1tGRFblJDc1guRflIJH7Mv/yC6Q6fmYLBsY
OwisB0CH+lJT3qwuGtRz2B7rk8f8AXVDw8PemqrDpqxkt/0+8nvEqPivV8MNSybkEZ/sjwNaiosr
FlkCAwEAAaOCA/kwggP1MHYGA1UdEQRvMG2BGWJhYmlja2EubWljaGFsQGljbG91ZC5jb22gGQYJ
KwYBBAHcGQIBoAwTCjE5MTk0NDY0MDiBGW1pY2hhbC5iYWJpY2thQGljbG91ZC5jb22BGmJhYmlj
a2EubWljaGFsQGhvdG1haWwuY29tMAkGA1UdEwQCMAAwggEsBgNVHSAEggEjMIIBHzCCARAGCWeB
BgEEARGBUjCCAQEwgdgGCCsGAQUFBwICMIHLGoHIVGVudG8ga3ZhbGlmaWtvdmFueSBjZXJ0aWZp
a2F0IHBybyBlbGVrdHJvbmlja3kgcG9kcGlzIGJ5bCB2eWRhbiB2IHNvdWxhZHUgcyBuYXJpemVu
aW0gRVUgYy4gOTEwLzIwMTQuVGhpcyBpcyBhIHF1YWxpZmllZCBjZXJ0aWZpY2F0ZSBmb3IgZWxl
Y3Ryb25pYyBzaWduYXR1cmUgYWNjb3JkaW5nIHRvIFJlZ3VsYXRpb24gKEVVKSBObyA5MTAvMjAx
NC4wJAYIKwYBBQUHAgEWGGh0dHA6Ly93d3cucG9zdHNpZ251bS5jejAJBgcEAIvsQAEAMIGbBggr
BgEFBQcBAwSBjjCBizAIBgYEAI5GAQEwagYGBACORgEFMGAwLhYoaHR0cHM6Ly93d3cucG9zdHNp
Z251bS5jei9wZHMvcGRzX2VuLnBkZhMCZW4wLhYoaHR0cHM6Ly93d3cucG9zdHNpZ251bS5jei9w
ZHMvcGRzX2NzLnBkZhMCY3MwEwYGBACORgEGMAkGBwQAjkYBBgEwfQYIKwYBBQUHAQEEcTBvMDsG
CCsGAQUFBzAChi9odHRwOi8vY3J0LnBvc3RzaWdudW0uY3ovY3J0L3BzcXVhbGlmaWVkY2E0LmNy
dDAwBggrBgEFBQcwAYYkaHR0cDovL29jc3AucG9zdHNpZ251bS5jei9PQ1NQL1FDQTQvMA4GA1Ud
DwEB/wQEAwIF4DAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDDDAfBgNVHSMEGDAWgBQP
KHw+NgA4EFCuPbghl4v3YFxheDCBsQYDVR0fBIGpMIGmMDWgM6Axhi9odHRwOi8vY3JsLnBvc3Rz
aWdudW0uY3ovY3JsL3BzcXVhbGlmaWVkY2E0LmNybDA2oDSgMoYwaHR0cDovL2NybDIucG9zdHNp
Z251bS5jei9jcmwvcHNxdWFsaWZpZWRjYTQuY3JsMDWgM6Axhi9odHRwOi8vY3JsLnBvc3RzaWdu
dW0uZXUvY3JsL3BzcXVhbGlmaWVkY2E0LmNybDAdBgNVHQ4EFgQUkqzfu5cylXTy8NtwPIfefT6M
f2EwDQYJKoZIhvcNAQELBQADggIBAEFZslGKeeBiN2h6//Vd+Vu+oZe+VE04Zl/7Z+JPc4RRKi+o
lwNUmSOu+ynJAtIMVXAQvQPiYtgp/5UVSGwbKzYaotA6OSRjTY1TLMEs/0ElPeGcKsZ71cDpJmUv
q3oO0nVueDhCL2BqesbKPmvm8xxSi/LEI3NnBO9J6FAHq/pUtXnw5Cx5w1D3Dv1Ddn/Q3iFOEUW0
Dp6RLxut3blj8Bw37oUjF8665w2HnQBR+PsGEIE7cdbh0piFJtd3EYqI5y3KgkoxDF1svmhS2Kqp
/Y7wHTZzZNz8OGapFS5f6Ln2zsl8pLDOC4PNT+saw8TBTIoVwqAyrxBVugJZSVhlr5D/UX3KXA0Q
93Irq/da1LG7YDU3yYrI552toYq+FTQ6ISyC0UQQI447ESG+GgEcak7fM9kzmjbqjOpxLcPNneRi
OfABxT1f+FyGxInR/idnFrEpxAz/oPjx73nEdfzfM/g1gaaOC8aue+JZ+wklaH5UItYDtveN4Bog
S3/pY+VNvywv7Dw4sWL57FMtTXAr6Thbucz5hXPSok3l0YQCFkf7WUEGGCZeTWeXpOaweUVHCwef
N9HQXQb7bMTMw5rmSWpijrAiqGmuXsZjmOCemMbgZgQCPkPrl3a9fEsEV8++9uU0r1EjPQ1yZbXv
ED5HTQ5kfw1VROy5SkYMuKEIOTV7MYIEETCCBA0CAQEwcTBpMQswCQYDVQQGEwJDWjEXMBUGA1UE
YRMOTlRSQ1otNDcxMTQ5ODMxHTAbBgNVBAoMFMSMZXNrw6EgcG/FoXRhLCBzLnAuMSIwIAYDVQQD
ExlQb3N0U2lnbnVtIFF1YWxpZmllZCBDQSA0AgQBbLKWMA0GCWCGSAFlAwQCAQUAoIIBcTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMTUxMTM1NTNaMC8GCSqG
SIb3DQEJBDEiBCBBqseTQnP8GbE9JYUcCZZnk0PaChvH5OsQQp+xzdc7vzCBgAYJKwYBBAGCNxAE
MXMwcTBpMQswCQYDVQQGEwJDWjEXMBUGA1UEYRMOTlRSQ1otNDcxMTQ5ODMxHTAbBgNVBAoMFMSM
ZXNrw6EgcG/FoXRhLCBzLnAuMSIwIAYDVQQDExlQb3N0U2lnbnVtIFF1YWxpZmllZCBDQSA0AgQB
bLKWMIGCBgsqhkiG9w0BCRACCzFzoHEwaTELMAkGA1UEBhMCQ1oxFzAVBgNVBGETDk5UUkNaLTQ3
MTE0OTgzMR0wGwYDVQQKDBTEjGVza8OhIHBvxaF0YSwgcy5wLjEiMCAGA1UEAxMZUG9zdFNpZ251
bSBRdWFsaWZpZWQgQ0EgNAIEAWyyljANBgkqhkiG9w0BAQsFAASCAgCVrxtrXCF4/8U3zfepgEyU
4Ph6c8ydjUYS6n3jGpBLYTD9IiKT7QSgwI1nRx2eHy/xBei7Sza9MY605Y7FjaycjBbIxIubVKyR
gEg1goqCv36ChHLIz9Ls2auPraIwPW9nmxKqDEnRIh2K6eLuuMF6Jd3+pyUzzjBDnWmrnfx8tcuu
VV/q50FSmOD12mA0hQR1cfIx7s2/0RilHIx5nj1CrVxTETFytcq27fs/1F4EG521nOYk24p0QU9t
lbNFCmpD6tD+40tWn9bBg8gvjcEFq6Y2KfFNwZJqP4nWJilerhqS0HEqAoLSH0jhHON92ItUM1Uk
YPeoSnah+va8FpNUzGrAp2WW1fXjeKBdPp1Bn9U7v4LtnIIvG/GRi21D+Jjzy4tNhUcnegityyZP
S78+CR0bKN/lCUOJn/XTPHfxdYZsu4q7KfFRTrOxcwfnU5vOl3J32u7ulHL1g99lH26SvljhDHOI
5fBQi61eac2cywKdwR2xbrDV9M+l4ZP6mh7mQTYIc6sbN2zq7CMAUYYMDe1Bo+2bcbcJk5n+KgtY
JSa4UPeCKRB58F6rl+6kO/rtz6OnASYXqbFPLhvZ9w1FIUhUTvVgmdaE439e4GlJ3zFvNksMrqRu
73eQN4r29zKjrodniLxN/JJudA6czFev9bSKj0f0AvJgpez8+T+5cgAAAAAAAA==
--Apple-Mail=_A7866E0A-6182-4995-9B42-A204F5CFB2CC--
