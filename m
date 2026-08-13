Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23A377ABD;
	Thu, 13 Aug 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607232; cv=none; b=FAZiZTMtSH9yn/terHFK/B3ALCq2NA30h8PuzYSMbNFNNGq0wGLUorVFLeOI96xkRWKKb4DUQbTar2umlIM+ctGBahwP5yz1/W8cXIxiKLrVYtAtJk4g3ymdgKqHVt9paafq9MBEiiQ7a5XuEozZ7Io9GnYvuiF3ykqmFHfCrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607232; c=relaxed/simple;
	bh=khXOj1GPuk9ZwhVgivJ1J/LF08RPSkKG4ZbKUPwNJhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As1bUr6XWI0tdZtwOo8NGE5VqatY3Bn4NpMpbn/tIgFqz3uR1LOyuvK9M258ia7m1QQi9QWIUu9lQvxnlYiylZbYetqQAzYsmEj4zSF53jKDvysoPyKjlOybdXkFjjcwpIiJ7sQBzfkdboz8JSLHHaq5hbG7VBzq/3FsDHVMqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Gru5+8zY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Gru5+8zY"
Received: from francesco-nb (2-224-16-253.ip168.fastwebnet.it [2.224.16.253])
	by mail11.truemail.it (Postfix) with ESMTPA id 2B1391F952;
	Thu, 13 Aug 2026 09:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1786607219;
	bh=OasgZ2lwasgL8zJh7tgHLLPMWzK9RGYBY8M5hc2VuyU=; h=From:To:Subject;
	b=Gru5+8zYKMLdaNoPB+Z1nflAJYTs7HqUDNQcbOosHwbUAK0KJX+Y0tNRdrmqBgxfE
	 LiArpKa00xOVApQi9ab1f2mDYTblFoxOeoGNUf+4O9M2tYYL4wTYZblLjvPwdXFN9H
	 D63jAoT4hg8+34KIArn7TJt0XP3NHyBHgHfBS5lacSs3QdcuouFaIjqRqokHDCutXR
	 oTHMF0HIAeVEjS+cn7gJOzyrmmo9Pwce2MZIeMviV26KiqaIZD/S/401aDKffjHw9Y
	 ssUhwqk9OthZ4vxhAxT1wZp7oGGaVEpuKr7Ywf/jR0Ge3UvIUHyupzKNIWSIjQ1b1D
	 xkqWViq6xoH5w==
Date: Thu, 13 Aug 2026 09:46:53 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Franz Schnyder <fra.schnyder@gmail.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"leonardo.costa@toradex.com" <leonardo.costa@toradex.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Sherry Sun <sherry.sun@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Message-ID: <20260813074653.GA11024@francesco-nb>
References: <20260629143439.361560-1-leoreis.costa@gmail.com>
 <20260715234736.GA288957@bhelgaas>
 <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>
 <i6x6wpua7wlwmdq3hitoo53wkptgp62tvegmkabcru3d54eqg3@yk4eehwaarn2>
 <3hxiy6aaiagt5zunntpidaeqc4or4wrebf7mu7asvyyibqmvo2@xhvasdqp64rw>
 <GV2PR04MB12019BD5B14FA63CDFCC2015B8CDD2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <20260811063752.GA7332@francesco-nb>
 <GV2PR04MB12019BC21C743E1BEF1BE8F4C8CDC2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <anwYlX0uC1nFCxnp@gaggiata.pivistrello.it>
 <t65y5d54axtksbfs7r4olcefqhwm6m4dz3njgnrnf7fcotj74i@o7avoznlafbj>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t65y5d54axtksbfs7r4olcefqhwm6m4dz3njgnrnf7fcotj74i@o7avoznlafbj>

On Thu, Aug 13, 2026 at 09:34:01AM +0200, Franz Schnyder wrote:
> On Wed, Aug 12, 2026 at 08:54:13AM +0200, Francesco Dolcini wrote:
> > So, unless I did some mistake in my manual test, the issue is related to the specific
> > PCIe card or some other subtle difference I cannot see yet.
> > 
> > For the record, the failure was detected by our CI/CD, and it is systematically
> > reproduced on multiple hardware boards.
> > 
> > Leonardo: any chance you can test with the same PCIe board that is failing?
> 
> I reproduced the issue on my setup (eval board + same PCIe card as in our CI/CD).
> 
> root@apalis-imx6-11486042:~# lspci
> root@apalis-imx6-11486042:~# dmesg | grep pcie
> [    0.162860] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
> [    0.162974] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
> [    0.163043] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
> [    0.163193] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
> [    0.505056] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
> [    0.505230] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
> [    1.508173] imx6q-pcie 1ffc000.pcie: Link failed to come up. LTSSM: POLL_CONFIG
> [    1.508314] imx6q-pcie 1ffc000.pcie: probe with driver imx6q-pcie failed with error -110
> 
> After applying the new sequence proposed by Zhu, the PCIe card comes up.
> 
> root@apalis-imx6-11486042:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 SATA controller: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA Controller (rev 02)
> root@apalis-imx6-11486042:~# dmesg | grep pcie
> [    0.162515] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
> [    0.162636] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
> [    0.162702] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
> [    0.162828] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
> [    0.488893] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
> [    0.489033] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
> [    0.591333] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
> [    0.591967] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> [    0.602947] pcieport 0000:00:00.0: PME: Signaling with IRQ 291
> [    0.603534] pcieport 0000:00:00.0: AER: enabled with IRQ 291
> 
> I'm completely out of the loop on this whole issue and I only helped out
> to test the patch. However, I wanted to add that before applying Zhu's 
> proposed sequence, I could only reproduce the issue by power cycling the
> module, as rebooting alone did not trigger the issue.

Interesting. This might explain why I couldn’t reproduce the issue in my
setup, rather than the difference being caused by the specific PCIe
card.

Franz: thanks for the test.

Richard: will you submit a formal patch, so we try to finally fix this
issue?  I guess it's now too late for 7.2, so be sure to cc:stable and
have a fixes tag.

Francesco

