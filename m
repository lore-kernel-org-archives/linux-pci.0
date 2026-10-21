Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.78.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583011;
	b=3lsNxoOtPLEeAAch5WjBdFZvmQZrNScuByHc3HH2ibQhCSZ7+R1Y2Qaardp/EFf9GcNk
	 EkKXXxB5xPA3G6HFclHgm0TnzjVfsJFjla/mbYDa88qgWM/5ywyjz5PkMM0wUvZ7zzJai
	 LBS6mddLma1MCd0ZOU1qCYz9bf/mmyPah/4XJZr3+XDVLr1HPAOg0P5pOEQZJoX6mARrx
	 ow7Q3EBoHChQ2tcz8g6yJZT9AZQ129DwZORms7LJw/zNKEYISVnBqdTjFRGCgPuoKD6q7
	 a/T8FavhB2azsXUt4Wdfts0XWGZLSwgdLi4r03DoS6Nc19kTbE8KkTVW7heIYFHracg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583011;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Proofpoint-ORIG-GUID:X-Authority-Info-Out:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-JNJ;
	bh=Sw5Eir+xy65c9AYKBeuz0upxYVB/n3ogNv/58XRlDuU=;
	b=T3GmAnZk5q5C5T7CmMsrAbjRWCqWl4eHIijwzSv4rRYbZ1ODf3bw5JHDl1ung87V80II
	 Ix93VHxhUf8vjHcOgaCq0qBKJRQVC9MN0USmeX1kFUDHagvvzsZ+KyTnwBMHUckIqb/Wl
	 oLQDgoAtgDXTScseYnrFXFxTFI1XcKs7nuoPvFjd3W5DS9L+HFnqnnrDrDwJB108571Ws
	 skxvMreb3LqGjWC7bXYFLdPlhedBH8hF+cE/t6ASqe2UHxRAe/SbrS7Q6S0Wy6+J4KTGx
	 LPw4o+QyyX+tg2u3FmUhVq5XhnfVbsxWfKmh94xk/MvMAyn0YXGur8vTzZHDqu6tlrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icloud.com;
	spf=pass smtp.mailfrom=icloud.com;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=aV3Q2gGB;
	arc=none smtp.remote-ip=57.103.78.171
Received: from outbound.st.icloud.com (st-2004b-snip4-11.eps.apple.com [57.103.78.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC2606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 11:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76BC2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=aV3Q2gGB
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id E4CB51800112;
	Wed, 21 Oct 2026 11:43:28 +0000 (UTC)
X-ICL-RepId: 01a15e46-0268-78d5-8cd7-027a83f8e2e5
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQFIHV8EWxxCDFYCVARLVxQEHVcaVhlWHVgUWgYOXnIZWhRcGFNFUR9UWFUJCgJRHFYNV0NUBF9QSxsOXAdLWhVVFw4CQh9QH0wWV0NEHxwZWhRcGFNFUR9UWEMZRVZpQQtPHV0ZWxxCZFhXCQoCURxWDVdDVARfUFQRV1ALXQVCX0gFDAUIVkBbGgBVBw1TFlwZUA4CDQNHCklWXFFfAkMJHgBfDkVREVQdXy1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1792583010; x=1824119010; bh=Sw5Eir+xy65c9AYKBeuz0upxYVB/n3ogNv/58XRlDuU=; h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version:x-icloud-hme; b=aV3Q2gGBkAbE+s+j4VBqtqB5tMNqTRzXYwQVyyGpbfV222wg6MAUsQCBykjxjR2Lifd9uSl6J92EcYvtYRQtf914Eya/AXz/W4sXAAce42jz9F5zhMEbTG2vU3SU0Z6NdFfZ5TyCW7HhrOd88Rkh1ampUTVK5Ydzabjkv2siU27tvZLLSxV5/d8Jq/LjaOxG9YElNN6OQiteZnX5zVNfBjcfIUofh/X4y6MSHcUawKyqXnp1j549miBCYhfKgCcF8UZxEDCxhPQBFulO2QtwQL2LP1p74t4QxzbGaOvmwNElLmLA3H4q20CEyw706hpELEE6V6lDRQXJ2T+ia9xxyA==
Received: from archlinux.lan (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id A0B6B180061B;
	Wed, 21 Oct 2026 11:43:26 +0000 (UTC)
Message-ID: <672f06a2cd0bb380fafeacc5f1731e1f4030f329.camel@icloud.com>
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
From: Edward Malik <edwardmalik95@icloud.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Andreas Wild
	 <andiwild@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Bjorn Helgaas
 <helgaas@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, M M <restafvalendergelijke@outlook.com>, blaat
 windows <blaaaat@hotmail.com>
Date: Wed, 21 Oct 2026 14:43:22 +0300
In-Reply-To: <f9ab8a2d-966f-4e96-b905-116919c5ac7b@leemhuis.info>
References: <20260801201244.4421-1-andiwild@gmail.com>
		 <20260917233355.GA1115024@bhelgaas>
		 <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
		 <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
		 <1b2cceea-8da4-4239-a955-e0c6b475a227@leemhuis.info>
		 <87c93553-d74d-4588-bd54-0ccb2728f327@leemhuis.info>
		 <20260929080109.53944-1-andiwild@gmail.com>
		 <c5ee9a34c6b7d3ca96538c9cc2914b603b0dce7e.camel@icloud.com>
		 <f9ab8a2d-966f-4e96-b905-116919c5ac7b@leemhuis.info>
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
X-Proofpoint-ORIG-GUID: jfvug_hKU7GqZHd4w8hhxoltUhobAMOP
X-Authority-Info-Out: v=2.4 cv=Kf/fcAYD c=1 sm=1 tr=0 ts=6ad8a561
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=U1xsJXor1XMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mehdgkVfAAAA:8 a=EYuV28GwPtMp2H73JGAA:9 a=QEXdDO2ut3YA:10
 a=J1pP9gvGZaT0y92QayzM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NiBTYWx0ZWRfX/QDSnfPWwh3f
 EMf/j+r7ReIulNjkJWcQ9z2EOuZPJ9Z8B3z7HXu/sLGC+BlM6HfWXIh+Ndpi2d5u4QGiBSOYKe9
 OOpWZq3IycFehpOFDx24Z5oEWqz8dfFFa8kchqNxMYVBL+BdX9nrg0YJnTDG1uZ/0JoESS1g+3B
 Pahw0nzVOEistB+xe/MvHPdf4p4W14pKzx+xgYVPhcinyz9fSGvX6XQLpi4BMhMSkq+quoXVRTI
 tvwq1JuXDcEuHvoykW3byfdtUL9yFHx/JbtfDlUNz0hnUDt2UROn1GD4jPkI01MC3NjFqTGz1J9
 FWRyx619b9jxmJuP+92C4LAePMilO1J5RZ+EPzRbUOq/lfyKsG1kBw9P08zTlE=
X-Proofpoint-GUID: jfvug_hKU7GqZHd4w8hhxoltUhobAMOP
X-JNJ: AAAAAAABAd/xUgKloXi36jrVhjDyGBkGJf4zI4bjApuQCd7QYEZ2/UXt9UYj+94eu2We7wFCs4QcGUUAf85mhDavELQT2cD+qZGfquZw8jLB6DYUWoNbI5Fa7ERoYDUAEYEx914B7hhQThVS8sHsRt+8C3ILXo7fdXTd+zgmsYBV5Co15KaHrEQhp90rImk7ti1GKgqy1edKtuPfJimXmZltUA8Iq8Z5zqzG/K6BramBeH2WGO+N61cluBYe3pF7GPSq/2rRftRBsSdAV/aUP5cqMBnCrej4M6JwKNH5H8pFfJVp8hygC82wdO9OeVq24LwVvyAFdE2cpWvyhvlhvsUxjwVHRJkbUb83zPusxEHhMi6vvrIq2CBz6RUewgtDO5u3J4NsqOF7/3dO0dKSKHRzbaBms0mIgBg/v3UM3vRtXhrsb2iRQcUp7wSDbcnAS8//Wpwxt4/2G1t+3rQds/T23SQ6HFkRynvuLS/sgDN0q5Wxpb4uGU+5IJmfljn6td6laboptso0wF243Ip86H+7Qt8DP0Ax3cj0+vFpZtnTthW40kJWNOQiDENtvn75QGlW4PciO59N9+NhOEeqscmKE1srBJOcPwdwa1M39JrFtWpVFdywFGp8RfoZmH/XxsggH3y8ehCOCqD5BOPgR8yyHXLntV7Q4/CJAYIyFPYX/qEeE9DcYpB6LwKKe2PCsvSapiWO4w5c4ctYd4yhJbTls+cmK6MJ3jnvjOLoyPsE4QiIeg9qVUjR15TGducroQZRWPPySl9dAjR1an+xr2gG+epF9I91sW5hFrfGvXhyhBC7A8CoOfsmwAqXv4+gx2wca3Lh1rx5Wh+Z0HhPx6Rqqp/vCFRq3nTTx/gIEoNf3PLt9gSV6+vQ39lx6HadqX+KsHmwGPZB1soZbjjqvk1QQukl7802NWc+bbPp8lGjtOZAm90uabgN6fLYbhrvlOBCnxBZLGIBx/Rkw3alCbf4+H2oXHJ
 yGiYlCSuIMUGEOdI2oielJ+ORLnf/fhWZKbrA4M9sloOWdT2MX60e18RY1YZZkrtN0w9Gtp0U9fTn/1W0AYghNaqwMqa6q+jtOUQv0eNBi3tAZ4QWsojn1ZJ/XsfXAo7B36tvYmpukW6zEdvMsgdRmvrcvnj3zDVcgoPUWtxPZh/e2566MyEUTKmmYkPXuwgtFVYEN4Io5/gh9uHHG3xJAW7rK8GJH1v5K8FKpSl+n9yW+R78dJx3/LuweyWFkVFJNORRTTeQmq45WG0KgTAYkX2K8uTjsLGJr1Mv0Fo7yuwRxtFCHh2eAVAFLwxC77EmoRlflrXaEYcj4XNL/UZ9RUJeDL0HpaQe6WyKeve2vtwOyweeQs9Q9LkxgV7T/EdcTGXqSxFjykVpE5PUbRXu1OOPTQ==

On Wed, 2026-10-21 at 10:24 +0200, Thorsten Leemhuis wrote:
> On 10/21/26 04:23, Edward Malik wrote:
> > I noticed another reported incident on the CachyOS Discord server:
> > [1.278083] pci 0000:00:1c.0: retraining failed
> > System information:=E2=80=A8https://paste.cachyos.org/p/35d9bd0.log
> > I'm sharing this in case it helps with investigating the PCIe
> > retraining regression maybe there is a common denominator among the
> > hardware=20
> >=20
> > Probably will see more now that ubuntu has moved to the new kernel
> > i
> > think
>=20
> I don't known about the others, but if you ask me this thread always
> was
> confusing, as we ended up discussing two different problems; over
> time
> it became even more confusing.=C2=A0 And one of the issues was fixed for
> 7.3
> iirc.
>=20
> So if you ask me I think it's overdue someone tests if *vanilla* 7.3
> (not a vendor kernel) is still affected and reports any remaining
> problems separately anew (e.g. in a new thread) in a way that can be
> read without reading this thread -- while still briefly dropping a
> link
> to this thread for completeness. Afterwards reply here with a link to
> the new thread.
>=20
> Ciao, Thorsten
i think i understand you want to seperate the threads between the patch
itself and the original quirk which was introduced by commit
72780f7964684939d7d2f69c348876213b184484 correct ? just to clear it up
the patch still works for me it's worth noting i don't think i
mentioned in my original report but the retrain failure happens to me
on my empty pcie slots it detects as me having 6 slots the 3 taken ones
it reports them as gpu, nvme, and ethernet controller=20
