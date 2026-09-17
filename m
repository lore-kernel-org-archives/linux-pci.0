Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23D3B27CE;
	Thu, 17 Sep 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676914; cv=none; b=imPK/gmP7nEZ8Cn4J0yTaF4BtxGk+VBwk7eYAN8aTk05jqBpbC7Uyt/oO8b0ObN/Nwg4TFTA3Xzusj63nYrJHMBqXtWb/yBrnLyPIHMigW+qU3X39LvikAMzMiSorQnDFCSZySNGmeccSdfILePu6eTsnloNwGO793Za7feWHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676914; c=relaxed/simple;
	bh=jeOrHXMj3aGrq0rwiKLlya/n6f2VZk3LNnrmc3iBKls=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d5olEPV0G9bT25HNPVIW37Cg12Tk518Y4hg62XzZAc60g4NDZDj+heXO8IU5JUgbTQHGLdvBMw2jX2VVHgJTqHvxxyFj505nn6dVH6mG9NpC8KDkr5prYCeP2CPU9fsN2FWwQYzyq5My2pzu309zOhAyAMbbyvCuhdjdWB2Be6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ea3Mteqd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KN8LLazJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ea3Mteqd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KN8LLazJ"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 8117C1D001AF;
	Thu, 17 Sep 2026 16:28:30 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 17 Sep 2026 16:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789676909;
	 x=1789763309; bh=dQSnXPOErAUYlxrzO2RZ74MubmylXYaCQrdeyKrYUi0=; b=
	Ea3MteqdaDCBlN04NxRlJlkODSOOYD+CK6GsrzkpMI7mi3M1QxTSIm6BnogsqSF2
	W902iaE/+wZQyGuL/RsXQ3faHAtBGHqtauHRvYQ1PZmGG7JfrkUN1Y8yTJiqBfRa
	1En0OpIP5V54+iWVJvrQz8ryzXoQKT/nHh6xg1gVIflUJvIp/b2NrlV8wTwK+Q7T
	FDtQCCU6VppN2rN1emglOAVq+/YAat3BS2c02LArBdqFTxr+mZo3kRNxQGQ6KheL
	lw8YUkvmd8KrpwdDMiPbF1oRNt5mk8KOpI8E6Y7aZESj73fY1pyeVSSTMKa6wfnc
	Ouvf5p7TlOPoyNdRM796Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789676909; x=
	1789763309; bh=dQSnXPOErAUYlxrzO2RZ74MubmylXYaCQrdeyKrYUi0=; b=K
	N8LLazJ+p+3TRA33qKr2KsVcSuuEVcKUCN8mNmLteGWh+lZwYrDpPJci8WDxuhZW
	KiZ92bBws7yGrAgOdFkjSd50jkmIT328cJ/OtB/LVN1awCZcdfOQzam8G7lMQAUs
	VlKW99pvcVfDSBi6MrBSjDmijQAM9DFLzfHmiHeiu3ui1IVVb1ievhTGjNCI9v2Z
	lEi0ipNmDibND25LutHGkgebXAP6n4oOZRULN5Y4aojP6LQXVgsJswXVEU3PoatL
	UtqNL8tHcBx/lW0z7s74FpGrrolqMVkkGtK2PP+QgXE/T8qiZDAJ2LQ6Gu6BXhXv
	fLML3vOOikyXiUJB/k3hg==
X-ME-Sender: <xms:aE2saqiok-c-6knFYOsnRvrAwspE8qJr9bTnmHP0BNI62degeV7j9A>
    <xme:aE2sal2T1EkiYE9bhVEPVye6vcVXadwtAkPrD3x1vJYB4OLXWKcs36y8G7PIIKo4o
    k9cM9zOWWvxntrxdnbFn_20O8xJL5Nxexw5K-9LdiAuxOj-vPsoCL2q>
X-ME-Proxy-Cause: dmFkZTFRv9h6v7nu+lxcC4g6+Rx4j3wacmqFRZ5xl2uHzVCxCgxkdidoTnjLkraylrTKIw
    Kfewlt0nvNtJDjt78HcdE5Zs+n5mFUcVSdVdEMfUXLYCOX9FgGhzm+Z1Zni31uw1M/bKS8
    hk3T07yUDXfnaq+7Ta6YNC0mMZCIsCOjeCm3tCosnxdHFfF1mVaV8Z6UziSPjmvozwVNec
    DWh7FpRs0Lc0Z0nXPcE1lbHC63Amak8WUHmoToeq2uMPI/PlpCxc/H/KB53Z7GMPX3oPRk
    nySy385vR5QBgq+rRS6mNKz6Rg/RBWTdy8maYn1ZlymNF17r3NiMeLueOspzW9rJBuywPD
    wI8CSI2dgyzBVm3n08bUxoO8WrTw4enFSbGoym75e7Pj/FY7qVht7A13t37gQwS28DxqaG
    fHe9TD+oqqEH6rgEIigCTEgRZQS4iv/Mvn5MshvajnjWrXgVt45lIqlFOIP582Gm0dfs2P
    eiir43Ama9RWuHitH89+m8ock1fFKAtED+TDBjlCauTcX7Aj5+/PDuBfr2p0ahYTaRuPVY
    EFPWkUXhOMSeYaYqb7qH6emycJ3ofk9UfSCOtzByKyWxYfqTAAWyC8ez6tCAvKhlKps02l
    C/Yf2Qi/URm9NWBjJQI+zAIZ44ng9kgZ2e6tDWvfVxjGb3ZDD6ICVDHqs/BQ
X-ME-Proxy: <xmx:a02satGR0RiEYbKl96zVlf1bGYjgLShLInFM6NqGsmdmOna_sHzTeA>
    <xmx:a02sarF3ESJiNm4lNs9jV0EiVD_UTu1F3wKxC2LSyc7593mVf97B9g>
    <xmx:a02sat0bxFIbk2Oe4wY87W8r9uDPEz-0jeY2lDyBtNxS8WPUhgikaA>
    <xmx:a02salcCXyapaYN6HU50Y7j_PbPvY0WeMvX5X0FF7SgVQeAOMfdMPQ>
    <xmx:bU2sairtEQOZJQ4z8Zczr6S7t5FpC4qgf3wrzeKcIDEkU5MNXrg-vbJ1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8E27B32A0084; Thu, 17 Sep 2026 16:28:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1v-knPnKEnN
Date: Thu, 17 Sep 2026 22:27:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bjorn Helgaas" <helgaas@kernel.org>, "Semih Baskan" <strst.gs@gmail.com>
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com, "Ray Jui" <rjui@broadcom.com>,
 "Scott Branden" <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Rosen Penev" <rosenp@gmail.com>,
 rani.hod@gmail.com
Message-Id: <7c2a8582-280e-471a-b4b0-037b2cda6ad8@app.fastmail.com>
In-Reply-To: <20260917183602.GA1036092@bhelgaas>
References: <20260917183602.GA1036092@bhelgaas>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026, at 20:36, Bjorn Helgaas wrote:
> On Thu, Sep 17, 2026 at 09:02:23PM +0300, Semih Baskan wrote:
>> On Thu, Sep 17, 2026 at 10:59:29AM -0500, Bjorn Helgaas wrote:
>
> Then it seems like we should remove the "brcm,iproc-pcie" compatible
> from DTs for platforms where bcma can enumerate it via EROM.  Those
> platforms can enable CONFIG_PCIE_IPROC_BCMA.  They still need the PCIe
> controller node in DT so they can use the wifi nodes below it, but if
> there's no "brcm,iproc-pcie" compatible, pcie-iproc-platform shouldn't
> do anything.
>
> Arnd, Rafa=C5=82, jump in if I'm in the weeds here.

It feels wrong to me to change the devicetee file when that arguably
describes the device correctly, and we still need the node for the
bcma bus probe in the end.

Normally, there should be a list of compatible strings so the driver
can make a more informed decision, e.g. the platform driver could
skip a device if it identifies the compatible string as one that
can be probed using the bcma bus when that driver is also enabled.

Unfortunately, it appears that all of these only have the generic
"brcm,iproc-pcie" string (or only the paxc variant), so that doesn't
work here.

Would it be help to change the probe order so the bcma driver
always comes before the platform driver?

      Arnd
