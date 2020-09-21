Return-Path: <SRS0=DH7G=C6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7159C43468
	for <linux-pci@archiver.kernel.org>; Mon, 21 Sep 2020 15:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9071022262
	for <linux-pci@archiver.kernel.org>; Mon, 21 Sep 2020 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600703455;
	bh=uj+S/CuwSCWQQp1MDiYdpqQcCN4vm3WQ+b90HfhEVv4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ruze8pEOPgPCz3vFEKOEiGAzQZWyT+b+74rTILvHvN8VAVha7p5FShs5S2dLJXD4K
	 qhnDYDps2mYE+th3Y8JYWuSJgU+p9EuBkiKXQGg7xuOEYp+ho4d8npWAO9AUL3eN/v
	 +C/RZWW0GvwQhkp6Dqk5yPAy5C7whRRazDYuuuZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgIUPuy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Sep 2020 11:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgIUPuy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 11:50:54 -0400
Received: from [192.168.0.112] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net [75.58.59.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3189E221EC;
        Mon, 21 Sep 2020 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600703453;
        bh=uj+S/CuwSCWQQp1MDiYdpqQcCN4vm3WQ+b90HfhEVv4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=v0EfJrNg+oLxwBCIr8fOyUgBuxu/RvMEMQi6vb99Cwd0nIgEMD3Gnqc8Zw+81gc87
         Vsq1UWHN6egf2y119Egl3gQ/Es3jIt9JTeApyBVKuurdpdMVm4BavMgRAv2y2mIyh3
         dE8KSO9vI1foXOr0BldUqD2otGElS5BLiNZgxwP0=
Subject: Re: [PATCH] PCI/portdrv: Don't disable pci device during shutdown
To:     Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1600680138-10949-1-git-send-email-chenhc@lemote.com>
From:   Sinan Kaya <okaya@kernel.org>
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <45e7272c-e074-d894-9319-ee29f451f282@kernel.org>
Date:   Mon, 21 Sep 2020 11:50:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600680138-10949-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/21/2020 5:22 AM, Huacai Chen wrote:
> Use separate remove()/shutdown() callback, and don't disable pci device
> during shutdown. This can avoid some poweroff/reboot failures.
> 
> The poweroff/reboot failures can easily reproduce on Loongson platforms.
> I think this is not a Loongson-specific problem, instead, is a problem
> related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.

This sounds like a quirk to me rather than a behavior that should be
applied to all platforms.
