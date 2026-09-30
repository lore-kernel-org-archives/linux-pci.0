Received: from outbound.pv.icloud.com (pv-2005e-snip4-11.eps.apple.com [57.103.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7C459AF9
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752557; cv=none; b=aUuLKgYZmOkiDdgbeX4zl8jIIMWfFlSE8DF2p05k1yw7UyLMJt13TZLzGBeD2+3g479oeggeGXYiSkxMdx42tUCb8s6bU2IbpowCXumeTBojdrOAzurAAzEfcHYlvLZeXJRuAisHVgzHmTchWKegkHIetBCtuxmSsjYaenq/GwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752557; c=relaxed/simple;
	bh=UPRqCQv2d8eX1E0F1TdKfOZWnR7IlEtgBd+6XWRqJU8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ssOJESAVwjhcIMjCEMgRmmtlOk2BAg6eYLezdC7yOvoAFwNlk35Y82UTh57QXoYM3hRrR6DldKClDklxlmKS+8LKtMZqAu2+9x2WAq7zjR09rwGL8PPWoCZj0yTQ4fwgg5ZC+KVoZBQbAU73tBeZSKwBaX5tFn3UDQ+GtqF2En0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=FqPDRdPR; arc=none smtp.client-ip=57.103.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="FqPDRdPR"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPS id F28AB1800118;
	Wed, 30 Sep 2026 07:15:48 +0000 (UTC)
X-ICL-RepId: 01a0f12b-6844-7da0-8f20-3edc180459e8
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwZZEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAGWRIYXBRcUFgeRhJWDV0JGRtEXlAbXwJCDxwTVhUTHUMZDysISgRDB0UCXgslEwlTVl8VFxtcABcGWxQERABeVFtQQwsdHlwGDlBdDR0ACBoJUEUAVVZeA1IASAAbB1QPCXIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790752551; x=1793344551; bh=qDJVc1Lg8Bgj3WjJ0lWn1/mZZ1/8Z5D+nRcBDaR1BD0=; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:x-icloud-hme; b=FqPDRdPRDxkDXlfJlALix1k4dtWFhna31BSdbYqgGu83qHCq85rKfxIYZb/uQoq6KvD73pDLFQcAqEvaW2Jvc2TbFM0WoQ5/x7dFy4XfPWJzQsdbrVMt4Kvaj66RREOCoKZWYKZyWZ+m2JKOnQaWELzwecGbHyK2naXJQzm0p0Pw2/9y+4jp1KqVwPIjS5hAdQOU7CdmUJwo7RsD7UHWJFIFvSdG6PEYnWIKBhV1gpbLRioxezNqHTiZj3z3JimMebcvnLlm7mXe8aLGc2CA+14MS2IhxENVw73Lt2L9CDsfsTPbipqYDAON5Xf7LX5RTF+l9eQWL3bMnGFC/fwtaQ==
Received: from [192.168.50.153] (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPSA id F1C6418002E4;
	Wed, 30 Sep 2026 07:15:45 +0000 (UTC)
Message-ID: <33c0b32e-11eb-4e3e-bb59-e349289c498b@me.com>
Date: Wed, 30 Sep 2026 09:15:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ferran <ferran.duarri@me.com>
Subject: [RFC PATCH] x86/PCI: Use the only online node for root buses with no
 _PXM
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-pci@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX63SyPsQNUiJi
 xM/A1gIVS3nNd9+NmeK3PWEhc5rrH5No3brwNp1JNd7Nd0rItuuqXB3yMA72QRNc3ndMrJnGFOB
 ctNtgcGjDLpbADfpUnp5UlhvHKyBlPxleQWzCqIH9afHax5vGwgigK5eNxJNSa7b6II7RZqEBPW
 4ELumai7KD+4OxVlKASj+bTp4QMmRQV594+/fqUf5CjPn4wxJ/Xe0LFnLTlI5fsm6U1Nq886WPM
 wz3IlbNPG2fVsuNSHZ4zvAyHyOziiG109C8st3DioKDeG1w4m1OyK4UngSX+WBw/+vniJ6aVRz9
 d9LEvPOxkmO8jHTxJ0tJjCOhMqvhYeoMEXJQEd2MLuLvasDUUzNR/XQqEpURwM=
X-Proofpoint-ORIG-GUID: xlRNljvrJlzC0zx51W92tHpyig2x_syA
X-Proofpoint-GUID: xlRNljvrJlzC0zx51W92tHpyig2x_syA
X-Authority-Info-Out: v=2.4 cv=TembdBQh c=1 sm=1 tr=0 ts=6abcb725
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=x7bEGLp0ZPQA:10 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HHGDD-5mAAAA:8 a=9H8p8Dz5MySjVPkIhQgA:9 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAAB/+A0FRISZACh1db7ezWr6GoVKzuMpzleNTFimwtxl4SJKXP6hSzgwz0aMKLfszu5ujPqkod259doy3zWE17usgwfR/LgNyWPrSuGjTBAMgMFHzrQnhkRQMdqT0KrTqmnzTHX3sx+G8WaiM5puDUpBOXllPyvFvLpd168NJ2X1B3brQYDTRlYcIpXTqou+u0/nx/O9XJMdYeI02oVGLImFlPie7YReNk2VgrdAau9F9MTRWa+RJw9MUq+49rEoQJgq2FAprIlGQ4ggjM7BgFGOV8Ib0VoEa+bemM7nWkMDoZwdcNMIIROUBs9G08k7gjhvw430Ars1+6+2xxWNOBSO/BGwlhDDZTSOn8mpx6kyu7PBb/SaRge92ahQXY0F7r59u+3/jALMjYJ6q4hLlhvI2Dumgo/XBAnT8ae8bxuOvEMqN+0icBwOpjhB7D4sWv7qSalJKyhrpuYen5JNo1/4RSy+PzBjK4uOZ/Mj1O1bUFSL3bBkHkqJtO1cQ8v0AV5ooC3AOQezqxDDUsowVAmHfpC8obBoryHQOMDoHm16Rl8PFkwhJgM+clBHrQYOvcEcqIAN2/iXdywpQp/nAkSuHhhVI5+gdzK5CheczYThyS8g4iXaTIYl1gLF68urSsFM7vVUg5L5VFNvo7VchdWka5T+nxEVLBEIKlu5cn6YAiZvAxW1l0EXWxZ3Nh5qntCt5dCxNiJnlNf0pl2L7q5DApRPVrj1EsLzheeWDzxV1hrOJbTvb44g6OL5K0f1dIA9etp9c1tm9mtau2IYHfBTb7SYOei2uT5+aeDHGh4+kpycuRj5QNNHtZige96fEFvAQQEOSC05nkl1dvroNon1GrtWSn+0XxhEq/aMeEzPl+ou8G1VrRrN8dNk+fKyzzsiyRsXvTm14cljBppMgGmaw5JrWqR6fAHKSwS07Ync44LkAboyprGYxLiXroZxB1Dy0j9Cq9MY7x2gvuqxzu+q4h
 mWvt9Km/BH/ymBagw2FCdZb/Az10Q+1FWeitvR7m+I0Ery66Q3lSfn+6mXNEXGNsBxZ8V/JscztheZo+Z6vlO5W3a/qrg+B4lhyLkMMICu1sFETQDEEBuSjMoz1gTES/Dw8EgRK8rnDzr0B3OCAhsFO3vFUJQrGnfqB3lIlzNFHkxtXXScUWU/gyWZhG+F/vRXyXjbmKKIlAZwq3BDw/+XOSJGH/JyxOefcyQi4qfC83hdS6/vAbn9AxwAPAr/eXDY2Eu6rC4u81zWkD6dWWWGNQIzkrDv3P0sz8ZUIVarKIQefaUpcDaZP9rwaeYdnmCzr4VMg==

When a host bridge has no _PXM and the Northbridge fallback finds
nothing either, pci_acpi_root_get_node() leaves every root bus at
NUMA_NO_NODE. With exactly one node online that isn't really unknown,
there's only one possible answer.

Seen on an ASRock B760M-ITX/D4 (i9-14900KF). nvidia-fs calls
pcibus_to_node() directly and warns "error retrieving numa node" four
times per boot, once for the GPU and once per NVMe. Rewriting the
per-device numa_node attribute from udev doesn't help, since
pcibus_to_node() reads the bus value set at enumeration.

Fall back to first_online_node when num_online_nodes() == 1. Systems
with more than one node are unaffected.

With this applied the warnings are gone over four boots. I didn't
observe pcibus_to_node() itself at the call site, there's no sysfs
file for it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Ferran Duarri <ferran.duarri@me.com>
---
Only user I've got is the out-of-tree nvidia-fs, hence the RFC. The
single-node condition is the same reasoning as Bjorn's 2019 "PCI: Warn
about host bridge device when its numa node is NO_NODE" change. Fine to
drop this if callers are expected to cope with NUMA_NO_NODE.

 arch/x86/pci/acpi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 7cd5388ed..2ae31c3e7 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -463,6 +463,13 @@ static int pci_acpi_root_get_node(struct acpi_pci_root *root)
 	if (node != NUMA_NO_NODE && !node_online(node))
 		node = NUMA_NO_NODE;
 
+	/*
+	 * One online node means there's only one possible answer, so don't
+	 * leave the bus at NUMA_NO_NODE just because firmware didn't say.
+	 */
+	if (node == NUMA_NO_NODE && num_online_nodes() == 1)
+		node = first_online_node;
+
 	return node;
 }
 
