Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF1364E92
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163009; cv=none; b=T19UIJD7V51hcU1o0kCJhsYE9dQfchrdd5lLrzN2DZBy2ihoj+tD9zlAHWNlIvJgVxr7xBCyywOYUZ1gcBegLpwOzQVycceQPruauXRdSJdad2vUKr1aSiOg+LBArouCyDytWjQS5Dm2NIGlSJp/sN0QHHbVNYLlHZZO66WJOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163009; c=relaxed/simple;
	bh=xufJC7/cvAmigCIamDa2w5Kt01W8fLKzWT3UauXNpi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMq0QqBO6WX9/m+IELTDV56Fw+E4WfsvYURHktIBErPN3IlPlp8aeZc8QANr6xFzkBS+Pd+Nc2jBB1XjMVmqOn7k2XGjL64fz6vxG+RiwqtjBqumS8Fr7ArD1gHU8DPrq3CB/OpaZSWbNwC5CYuydelteV3g4iSkF/xUgZgBbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaWcYKhO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaWcYKhO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781163007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuw0J3g45Skc3QfhRqB7uACn5uzzyF7cYO293roxvqI=;
	b=YaWcYKhOg+Dl2OKLbHWnTDN6q1PkjpCEMl0+1qHxbVDKJ4svSlkcBTJg+bHjRQCOXg5lg5
	Zsrml/rtQImnne6kp+krDgp++5ruF4EalsroAFqoBxTZZO3IuhqZo8Kapz2qRoRmhPQ9md
	SrHc18jD9l5Qctvjr2KGHfMdvEqmXWw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-kKtD1rzIMJGQH5L-LcWCpQ-1; Thu,
 11 Jun 2026 03:30:05 -0400
X-MC-Unique: kKtD1rzIMJGQH5L-LcWCpQ-1
X-Mimecast-MFC-AGG-ID: kKtD1rzIMJGQH5L-LcWCpQ_1781163004
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B36451800378;
	Thu, 11 Jun 2026 07:30:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.63])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C97B30001A1;
	Thu, 11 Jun 2026 07:29:57 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	bhelgaas@google.com,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mani@kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v8 2/3] PCI: Add device-specific reset for Qualcomm devices
Date: Thu, 11 Jun 2026 09:29:56 +0200
Message-ID: <20260611072956.22448-1-jtornosm@redhat.com>
In-Reply-To: <20260610131517.6d7bd63a@shazbot.org>
References: <20260610131517.6d7bd63a@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Alex,

> This seems to suggest that the D3cold reset method is also untested...
> I'd suggest dropping the D3cold throughout, unless you can get someone
> to volunteer to test it. It seems like you really just want this quirk
> to do a D3hot regardless of NoSoftRst+ with a select set of devices
> where it appears to do more than nothing, where doing nothing is
> effectively what's left after the other reset methods are being quirked
> off for being worse than nothing.  Thanks,

Agreed, I don't have access to hardware with _PR3 support to install the
Qualcomm devices - all my testing for these has been on platforms without
_PR3 (desktop M.2 adapters).  
I'll drop the general d3cold infrastructure (patch 1/3) entirely and simplify
patch 2/3 to just a D3hot-only device-specific reset for the specific Qualcomm
devices where testing shows it works despite NoSoftRst+.
  
v9 coming soon.

Thanks,

Best regards
Jose Ignacio

