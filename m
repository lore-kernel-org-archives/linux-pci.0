Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D3C2D0A3
	for <linux-pci@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7381022249
	for <linux-pci@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+UnK8b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgKLNDe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgKLNDX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 08:03:23 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE849C0613D4
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:22 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so5908514wrl.7
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4JGD+U5wzrPrHuAbcShPgq/7SS7eVhaJGMY13GukQwc=;
        b=L+UnK8b6jHlxkKjKLGZ2KBHb9UiCE2bYESXAd9FIJCk+MSUtGNGNYYhyKKC6RRifPQ
         PgL5pNXsAPyMWO+HtY1Gz8tYhOV7PCazvQjyezuUbsHfk2M9AaPxMotgauVMZKLo3hiQ
         M9zO8+yMql5b+8b9cbMFbwaUXk+eUu0753EmMvk7l1HFsWM70OEcQW79vBJFUlgt+5VM
         KTrz/bb1p5Gfk+J3GZ0/zY9ErMbza+/lZXbPnTQ6Y0oHv+Z0tDMeL6+cldPYswOsQVrL
         O6uN/kZ4gFKC9yygejnVCUVwrluiILl9XVtVOe0uMkP8IGro9CIcUykOaW84nVGNiLuD
         7kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4JGD+U5wzrPrHuAbcShPgq/7SS7eVhaJGMY13GukQwc=;
        b=Gducz7rDVJ7Fb29XH0gI+PwnsVMre/nWJuYlQ3WJmCQg3AVUjK8z7AOLIWDtJYFmkv
         kA7RNITZIbaopSZkF/1+pLmC+Dbt3BFFkTmkd29ShcA+7B0yEJovC2o0hMmdMWUPmDHY
         CiaL8ukCFR5nnHgtkg4frwOvnai3Q85cRGThK5N3wA2tpDcRgxsEuGsMGYgxlirn8Fxo
         2qjPzjbf23Twp+B7reAwTTrYGsdAJnvQZ+7bVXgnqU2QqdfoJvWp1A90uW2rL+KXwlj9
         QbXBaLKIlvo/1Fj+CK65vOmUOC8ERP+NZovZ+fY/C76DAQ6WASc2PUyauGSNgQtDotPc
         L9Ug==
X-Gm-Message-State: AOAM533UHjX89NA+JMxz1oXRVA/9WURM5uy7/t2k4ZgT6sNzcvbkQC/J
        K9wJiramPrGn109nXjpLjy8tYw==
X-Google-Smtp-Source: ABdhPJxo3CkbVLQBJt0LU+udw0kuJH0eA8lhV+b7zpBZqVmuSk9IILiYnXCbLaDmkxe9gZqnDT5qGA==
X-Received: by 2002:adf:9d84:: with SMTP id p4mr24594639wre.370.1605186201700;
        Thu, 12 Nov 2020 05:03:21 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:20 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v8 5/9] ACPI/IORT: Enable stall support for platform devices
Date:   Thu, 12 Nov 2020 13:55:17 +0100
Message-Id: <20201112125519.3987595-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Copy the "Stall supported" bit, that tells whether a platform device
supports stall, into the fwspec struct.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70df1ecba7fe..3e39b2212388 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,6 +968,7 @@ static void iort_named_component_init(struct device *dev,
 	nc = (struct acpi_iort_named_component *)node->node_data;
 	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
 					   nc->node_flags);
+	fwspec->can_stall = (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED);
 }
 
 static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
-- 
2.29.1

