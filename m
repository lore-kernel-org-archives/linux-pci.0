Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2D3ADBA7
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528705; cv=none; b=QlkxWudIHls6WQ4SWm1vh6EranjIzVO++g6cNTnZXZuOZR2FT1F/Hnt143sAHoY2fVtLGaEy+HNbncUr/5zq2UCneRl2Ph7KB6YNSD6yY2Xp9O0s13lWyjs9qipoKoyinwXl5BaVVE2ffCRlv61fpFn50qWa79wICHkUYMtOm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528705; c=relaxed/simple;
	bh=24KfME6YaK0rFqYLax/YOH/Kr2A1S3NsrP5E8iqazls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elGKOs36t4V9q/5htE1b5Hy+h2lbWLgfdA0Nxv6Q8zBdhRagiN7WnREa90fUmo32nCSxNjKnjFX/qYiZaKIoYYGeIow4F/81AO5D4rD0g9kePd6b2LRPP9ikb5zr3vNsOxY4YbW4DxyGiWZOejneKIUYRsbP/ftK0bMw0q7WBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Go9rTBad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Go9rTBad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784528694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24KfME6YaK0rFqYLax/YOH/Kr2A1S3NsrP5E8iqazls=;
	b=Go9rTBadIwt7eOZkp0a2B0EiRKd2sbDbIcSmYyOx06erL0j2Dk1VeUTet4PJlSgy9Ie/o3
	v2EZK/OImozHcK2MUqFLTXTjY4T3Q23r1yigxcuzl8MnRs5zG/4seaYY7ir1+Zas19qK2C
	7VgE3jhXgdo+QhhTJSF084Tdhkn33kg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-63QoUVMuPE6Au3c6VZwjVQ-1; Mon,
 20 Jul 2026 02:24:48 -0400
X-MC-Unique: 63QoUVMuPE6Au3c6VZwjVQ-1
X-Mimecast-MFC-AGG-ID: 63QoUVMuPE6Au3c6VZwjVQ_1784528687
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4D9D180134A;
	Mon, 20 Jul 2026 06:24:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.69])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1CB4195422C;
	Mon, 20 Jul 2026 06:24:40 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org,
	mani@kernel.org
Cc: jtornosm@redhat.com,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v12] PCI: Add device-specific reset for Qualcomm devices
Date: Mon, 20 Jul 2026 08:24:39 +0200
Message-ID: <20260720062439.8993-1-jtornosm@redhat.com>
In-Reply-To: <20260630065815.199693-1-jtornosm@redhat.com>
References: <20260630065815.199693-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Bjorn,

Gentle ping on this patch. It has Mani's Reviewed-by and has
been tested over 100+ VM reset cycles for both WLAN and modem
devices.

This patch adds device-specific reset for Qualcomm PCIe devices
(WCN6855, WCN7850 WLAN and SDX62/SDX65 modems) that lack working
reset methods for VFIO passthrough. The reset uses BAR-space
hardware registers, replicating the sequences from ath11k/ath12k
and MHI drivers. Without this, these devices cannot be reused
after an unclean VM termination.

The approach follows Alex's guidance through the series:
device-specific reset via pci_dev_reset_methods[] (suggested
in v5), and BAR-space hardware reset registers instead of
D3hot power cycling (refined with Mani from v10 onwards).

The quirk_no_bus_reset part was already merged for v7.2, and
this device-specific reset completes the solution.

Is there anything else needed for this to be considered?

Thanks,
Jose Ignacio

