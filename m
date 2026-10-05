Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A874346AC5
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201669; cv=none; b=LmzSjBYEob60iMTIXQKSFAW4sOrR3wrtIv7OhP/S8XvFVX7J1/5SGOxo9QLEXbTQNO2Q0mOno5yHPXoirniAfSINGPScs3Kg94x22/CfiKkJCJDP+Mjl9fbGrltKvK1goa33LYx7IDL2XR49LAR3DIXOPNUSxo3BY2HMLst/wdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201669; c=relaxed/simple;
	bh=H/kHJw9LcGCcKRAnKglPQnsaIZ/ZF5vj0tr6ekL8oKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cya9nfJSk/ZIYTYNcKjjKTUBy2xq6fJTOY5/caNMFcL0R4zalWRhSv5bje+WwwXb3CuhnRV7NsANwjbBDD606t39HC1gwq4efjWyR5Ch/f0/dNDGELPRKYIPg/Xz5qPc2AR/Jj5Uw93n29xD5vN/UyHY4jN2k0Y17PfgFIpVYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6UxZaNN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6UxZaNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791201667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/kHJw9LcGCcKRAnKglPQnsaIZ/ZF5vj0tr6ekL8oKY=;
	b=I6UxZaNNhRyJk8/98Axir/kLUvUKy86IpLRrBSMFw0oF5wYtiQBGUIbEs75bwsqKSpFnMb
	f/ij8Usi9kwHPit6TlvqXP7w0wBuZBUr9YYIEKmzl+ETEyjlsEcUIe/JQ4xV/gC7ZSyb95
	sAHLr5CS7YaHAU4zlqYJWW9vMOfNqGI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-id0ycPwqM-yF-zVfcjuSkA-1; Mon,
 05 Oct 2026 08:01:03 -0400
X-MC-Unique: id0ycPwqM-yF-zVfcjuSkA-1
X-Mimecast-MFC-AGG-ID: id0ycPwqM-yF-zVfcjuSkA_1791201662
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADB261944B13;
	Mon,  5 Oct 2026 12:01:02 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3825F1800351;
	Mon,  5 Oct 2026 12:01:01 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v15 1/2] PCI: Add device-specific reset for Qualcomm SDX62/SDX65 modems
Date: Mon,  5 Oct 2026 14:00:59 +0200
Message-ID: <20261005120059.111630-1-jtornosm@redhat.com>
In-Reply-To: <20261005110741.D53A31F00893@smtp.kernel.org>
References: <20261005110741.D53A31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

> [Severity: High]
> Could restoring PCI_COMMAND here cause a system address conflict?
>
> If the saved cmd originally had the PCI_COMMAND_MEMORY bit set (for example,
> when called from a path like Xen PCIBACK's pcistub_reset_device_state),
> writing it back immediately enables memory decode. Because the hardware reset
> has just occurred, the device's BARs will have been cleared to 0.
>
> Does this create a risk of silent memory corruption by allowing the device to
> claim physical address 0 before the PCI core has a chance to restore the BARs
> properly in pci_restore_config_space()?

The MHI SoC reset is a device-internal reset that resets the device's
firmware logic, not a PCIe fundamental reset. PCI config space
(including BARs) is maintained across this type of reset, so BARs
are not cleared to 0. The PCI_COMMAND save/restore just enables
memory access for the reset operation.

