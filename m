Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16DFC77B7A
	for <linux-pci@archiver.kernel.org>; Fri, 19 May 2023 04:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjESEq6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 May 2023 00:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESEqz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 00:46:55 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B010DC
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 21:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1684471565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lvv/vx9hgircVnC1zAHTlfLyXRGrim9JAwynveGdEPg=;
        b=b3bfWw6WGLlXI/o9kxeVVXFeHQHkQgWIXOVhS352UFgMCThoVdIYGX28IbvPEFuMIjTxJS
        s+g1O8b8X3f6zH/JcbQXKUSRDftsXni4r5bCwdwPSx3mkrh9IHyJqBiQ0uPWZqzZv+o5GQ
        iIvJEhijXCO3Lpn1W+BDUsDo4Zl78t+LyYFfTj0oZutSWNRQqhuQwvMVYj55BH91WbDS48
        sNLt4h8pOKbkxla0FEo8XmrVBRt4SkHBGeWruQZ2dd7szedwiCpaEk8LdzHABn+Q6ZH3Xo
        XZj3nxhZfoycYMEQt8y5SCzlp2KV9DxyNgJ/lFbBDQzXjkGqdsuFmpRxPKccpw==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-402-ULVD0C1INFG90-klTOqsyQ-1; Fri, 19 May 2023 00:46:02 -0400
X-MC-Unique: ULVD0C1INFG90-klTOqsyQ-1
Received: from sgsxdev002.isng.phoenix.local (10.226.81.112) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.34;
 Thu, 18 May 2023 21:45:58 -0700
From:   Zhu YiXin <yzhu@maxlinear.com>
To:     <lchuanhua@maxlinear.com>, <torvalds@linux-foundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pliem@maxlinear.com>, <qwu@maxlinear.com>, <yzhu@maxlinear.com>
Subject: [PATCH v2 0/1] Update entry for PCIe driver for Intel LGM GW SoC
Date:   Fri, 19 May 2023 12:45:54 +0800
Message-ID: <20230519044555.3750-1-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v2 changes:
Remove group email address as it is not valid to external user.

v1 changes:
1. Updated Maintainer email address
2. Add group email address as support email address

Zhu YiXin (1):
  MAINTAINERS: Update entry for PCIe driver for Intel LGM GW SoC

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.17.1

