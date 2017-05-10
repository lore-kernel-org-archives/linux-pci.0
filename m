Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32869 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdEJFxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2017 01:53:18 -0400
Date: Tue, 9 May 2017 22:53:14 -0700
From: Nick Desaulniers <nick.desaulniers@gmail.com>
To: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: fix duplicate 'const' declaration specifier
Message-ID: <20170510055313.nnitvflu3g4uglyb@lostoracle.net>
References: <20170510030121.19667-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170510030121.19667-1-nick.desaulniers@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please disregard this patch.  I think I may have found a bug in Clang,
or at least an incompatibility with GCC 7.1.

Clang bug: https://bugs.llvm.org/show_bug.cgi?id=32985
