Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE41B2;
	Wed, 13 Dec 2023 02:49:32 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0B3B128042DAC;
	Wed, 13 Dec 2023 11:49:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 004AD231117; Wed, 13 Dec 2023 11:49:30 +0100 (CET)
Date: Wed, 13 Dec 2023 11:49:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 1/2] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
Message-ID: <20231213104930.GB31964@wunner.de>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 12, 2023 at 10:46:36PM -0500, Ethan Zhao wrote:
> move pci_dev_is_disconnected() from driver/pci/pci.h to public
> include/linux/pci.h for other driver's reference.
> no function change.

That's merely a prose description of the code.  A reader can already
see from the code what it's doing.  You need to explain the *reason*
for the change instead.  E.g.:  "Make pci_dev_is_disconnected() public
so that it can be called from $DRIVER to speed up hot removal
handling which may otherwise take seconds because of $REASONS."

Thanks,

Lukas
