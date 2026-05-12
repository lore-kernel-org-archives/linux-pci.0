Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0503D45E4
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606242; cv=none; b=TfsOIVqr9xFZCcf+C8haLhFp/q38eDD+TMHPO0H+dxbwer8fo+X66V8GfQb4tB8emL0lOF91hUBncZ4BHkJZa8kMcGufBJSZByFQPZqBu63/yXqnQOMejG3O347AtTDZEUR2Z2lLMm/BKn7qcllPjgVviVFahwME3kjco8YgSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606242; c=relaxed/simple;
	bh=Oe/GIsy89lagNeD0WEvmK0wnd8GTxbtSRowCVJCo/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a61Xac6ZeTPHRlrAyWgs7DhjASSp1wTUhKlmNx/YG/2jRGcMvVvHqf3eBQh4gvE42YAfiFht3EddSz0p7AB/bGnY2PuYiqYAILD//ZB4z/4fjjXiqhS8q9fh3mEEPsWkigqnw67TWBr9n1GwxTcz9D+CaJp0HzrhETuzswu9Fqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dU9PXVvd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dU9PXVvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778606240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe/GIsy89lagNeD0WEvmK0wnd8GTxbtSRowCVJCo/cU=;
	b=dU9PXVvdN8q7hA+xFPFP/6E23uMZANb9QKt7BMJ6ti8AbMedZQI1ehvzt3ZGVlABAdepTo
	ykyQWp7fke91yOM4jd7u4iBdbOwGvPYFnXmEmbxvpW1FZgtUuBwzxz5vCvmwQwOS4L4JBP
	MGN2NuZlbgoyexmW+EV1AxCM6QNmY/4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-OgCnxmSiMES3zTvADWRj8g-1; Tue,
 12 May 2026 13:17:16 -0400
X-MC-Unique: OgCnxmSiMES3zTvADWRj8g-1
X-Mimecast-MFC-AGG-ID: OgCnxmSiMES3zTvADWRj8g_1778606235
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86FE71800283;
	Tue, 12 May 2026 17:17:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABD9A19560A2;
	Tue, 12 May 2026 17:17:13 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Force PM reset for Qualcomm devices with NoSoftRst+
Date: Tue, 12 May 2026 19:17:11 +0200
Message-ID: <20260512171712.910994-1-jtornosm@redhat.com>
In-Reply-To: <20260511133643.73a16e69@shazbot.org>
References: <20260511133643.73a16e69@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Alex,

Thank you again for your detailed feedback and help

>>> What does reset_methods sysfs attribute report for these devices on an
>>> unpatched kernel?
Sorry for my earlier confusion about CONFIG_PCI_RESET_SYSFS - I now understand
the reset_method sysfs file has been available for a long time without any
config option.

Testing confirms only "bus" reset is available on default kernel for these
Qualcomm devices. PM reset returns -ENOTTY (blocked by NoSoftRst+ flag), and
FLR is not advertised. This confirms the default kernel has no working reset
method for these devices.

> Then why aren't we setting quirks to use quirk_no_bus_reset() for these
> devices?
You're right. I am going to try quirk_no_bus_reset() to disable the broken
SBR method.

> PS - D3cold might be an interesting reset method that could be implemented
> for single function endpoints in slots that support it.
I like the suggestion, I am going to implement a generic d3cold as a general
PCI core reset method for single-function devices (not only for Qualcomm).
I have seen that using pci_set_power_state(dev, PCI_D3cold), if no _PR3
support by the platform, it will use D3hot fallback.

The combination of quirk_no_bus_reset() + general d3cold reset method can
provide a much better solution for these devices and the new reset method
allows the configuration if necessary.
I'll send a next version with this.

Thanks

Best regards
José Ignacio

