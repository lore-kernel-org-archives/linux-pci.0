Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dub004-omc3s21.hotmail.com ([157.55.2.30]:60252 "EHLO
	DUB004-OMC3S21.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179AbbHXUql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 24 Aug 2015 16:46:41 -0400
Message-ID: <DUB128-W21A325258A168FAE8CDDF29C620@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: linux-4.2-rc8/drivers/pci/setup-bus.c: 2 * redundant conditions ?
Date: Mon, 24 Aug 2015 20:41:38 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello there,

1.

[linux-4.2-rc8/drivers/pci/setup-bus.c:946]: (style) Redundant condition: reallo
c_head. '!realloc_head || (realloc_head && !add_size)' is equivalent to '!reallo
c_head || !add_size'

Source code is

    size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
        calculate_iosize(size, min_size, add_size + size1,
            resource_size(b_res), min_align);

2.

[linux-4.2-rc8/drivers/pci/setup-bus.c:1094]: (style) Redundant condition: reall
oc_head. '!realloc_head || (realloc_head && !add_size)' is equivalent to '!reall
oc_head || !add_size'

    size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
        calculate_memsize(size, min_size, add_size,
                resource_size(b_res), add_align);

Duplicate.

Regards

David Binderman
 		 	   		  