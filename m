Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] HWRNG: thunderx: Add Cavium HWRNG driver for
 ThunderX SoC.
To: Omer Khaliq <okhaliq@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, mpm@selenic.com, herbert@gondor.apana.org.au,
        Ananth.Jasty@cavium.com, David.Daney@cavium.com
References: <1471994835-2423-1-git-send-email-okhaliq@caviumnetworks.com>
 <1471994835-2423-3-git-send-email-okhaliq@caviumnetworks.com>
From: Corentin LABBE <clabbe.montjoie@gmail.com>
Message-ID: <874d0bce-cf9b-8772-5af4-ec3844b3b255@gmail.com>
Date: Wed, 24 Aug 2016 07:46:19 +0200
MIME-Version: 1.0
In-Reply-To: <1471994835-2423-3-git-send-email-okhaliq@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello

> +/* Read data from the RNG unit */
> +static int cavium_rng_read(struct hwrng *rng, void *dat, size_t max, bool wait)
> +{
> +	struct cavium_rng *p = container_of(rng, struct cavium_rng, ops);
> +	unsigned int size = max;
> +
> +	while (size >= 8) {
> +		*((u64 *)dat) = readq(p->result);
> +		size -= 8;
> +		dat += 8;
> +	}

I think you could use readsq()
This will increase throughput

Regards

LABBE Corentin
