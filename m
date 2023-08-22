Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B1EE49A3
	for <linux-pci@archiver.kernel.org>; Wed, 23 Aug 2023 01:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjHWBhR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Aug 2023 21:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 21:37:16 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:37:14 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB403E46
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 18:37:14 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-ff-64e54a4ceadf
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 80.3A.10987.C4A45E46; Wed, 23 Aug 2023 04:52:45 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=hNYr6cFMYwQeGRs4CnYcKcCt0qwvzpcI5ZrI9JbxVcTPkd/ohgEYrZNAhdIQemcDm
          JCA9m/H34it6f/By5U5rfHrG7qwalPtpUySUEl20Uy9BH3ZoHDHk+E2pBQXCaK0iY
          Qg9vO7KsO3c2qDteyOudR4Q0n+AtQvqVf558DUjMk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=WkqUsnBo3AfL4pczW8w2v7q2ZtXqxvyF19EccskHMXHq30idthjZdULLlYiNXQh5S
          hU9xHFfVUFEqAjmu9Q/TCVGDnmX9cD9OnwjqQ9S1iBZ/XhQyVkNgwRjtNjMIULGtl
          cNH2DeYDrgvX24VhD0QYIuVUcGLLv4lE6ibuq2Fq4=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:06 +0500
Message-ID: <80.3A.10987.C4A45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-pci@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:19 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVyyUKGW9fX62mKwemd3BZn5x1nc2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCR2DrxB3sXIxeHkMAe
        Jon13zrAHBaB1cwS/69dZ4JwHjJLbHr7jAmirJlR4k/HTTaQfl4Ba4kVhxaxg9jMAnoSN6ZO
        gYoLSpyc+YQFIq4tsWzha+YuRg4gW03ia1cJSFhYQEzi07RlYK0iArISHy/vAWtlE9CXWPG1
        mRHEZhFQleic8wPMFhKQkth4ZT3bBEb+WUi2zUKybRaSbbMQti1gZFnFKFFcmZsIDLZkE73k
        /NzixJJivbzUEr2C7E2MwEA8XaMpt4Nx6aXEQ4wCHIxKPLw/1z1JEWJNLAPqOsQowcGsJMIr
        /f1hihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeW6FnyUIC6YklqdmpqQWpRTBZJg5OqQbGy7f1
        XnHZZW49Xqv00/G92OEXNXOLW+sZ5hU8tD8wbbupXJQG+yP/IO+5xXmzF+6ZyfzmmkjChXnL
        mKR2rjh0tLx/W23AkaB74dP0uk2430W3H1BI4JaWfl+aPuvWjA2TJ8yN/SN8dHWE7m/D3xf/
        ma0NVL766EGc0cSjSfvt3x7i9NRzYzM0V2Ipzkg01GIuKk4EAKo7iuBAAgAA
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

